//
//  GetReverseGeoCode.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import Foundation

func GetReverseGeoCode(latitude: Double, longitude: Double, key: String, urlOpenCage: String) async -> (GeoRecord) {
    
    var openCage = OpenCage()
    var geoRecords = GeoRecord()

    let lat = "\(latitude)"
    let lon = "\(longitude)"
    let url = URL(string: urlOpenCage  + lat + "+" + lon + "&key=" + key)
    let urlSession = URLSession.shared
    
    do {
        let (data, _) = try await urlSession.data(from: url!)
        openCage = try JSONDecoder().decode(OpenCage.self, from: data)
        let count = openCage.results.count
        for i in 0..<count {
            var geoRecord = GeoRecord()
            
            if openCage.results[i].formatted != nil {
                geoRecord.formatted = openCage.results[i].formatted!
            } else {
                geoRecord.formatted = ""
            }
            
            if openCage.results[i].components.country != nil {
                geoRecord.country = openCage.results[i].components.country!
            } else {
                geoRecord.country = ""
            }
            
            if openCage.results[i].annotations.flag != nil {
                geoRecord.flag = openCage.results[i].annotations.flag!
            } else {
                geoRecord.flag = ""
            }
            
            if openCage.results[i].components.county != nil {
                geoRecord.county = openCage.results[i].components.county!
            } else {
                geoRecord.county = ""
            }
            
            if openCage.results[i].components.postalCity != nil {
                geoRecord.postalCity = openCage.results[i].components.postalCity!
            } else {
                geoRecord.postalCity = ""
            }
            
            if openCage.results[i].components.village != nil {
                geoRecord.village = openCage.results[i].components.village!
            } else {
                geoRecord.village = ""
            }
            
            if openCage.results[i].components.hamlet != nil {
                geoRecord.hamlet = openCage.results[i].components.hamlet!
            } else {
                geoRecord.hamlet = ""
            }
            
            if openCage.results[i].components.neighbourhood != nil {
                geoRecord.neighbourhood = openCage.results[i].components.neighbourhood!
            } else {
                geoRecord.neighbourhood = ""
            }
            
            if openCage.results[i].components.city != nil {
                geoRecord.city = openCage.results[i].components.city!
            } else {
                geoRecord.city = ""
            }
            
            if openCage.results[i].components.town != nil {
                geoRecord.town = openCage.results[i].components.town!
            } else {
                geoRecord.town = ""
            }
            
            if openCage.results[i].components.state != nil {
                geoRecord.state = openCage.results[i].components.state!
            } else {
                geoRecord.state = ""
            }
            
            /// finne geoRecord.place
            ///
            /// city
            /// town
            /// village
            /// neighbourhood
            /// hamlet
            /// state
            ///
            
            if !geoRecord.city.isEmpty {
                geoRecord.place = geoRecord.city
            } else if !geoRecord.town.isEmpty{
                geoRecord.place = geoRecord.town
            } else if !geoRecord.village.isEmpty {
                geoRecord.place = geoRecord.village
            } else if !geoRecord.neighbourhood.isEmpty {
                geoRecord.place = geoRecord.neighbourhood
            } else if !geoRecord.hamlet.isEmpty {
                geoRecord.place = geoRecord.hamlet
            } else if !geoRecord.state.isEmpty {
                geoRecord.place = geoRecord.state
            } else {
                geoRecord.place = "Unknown"
            }
            
            ///
            /// Finner:
            ///
            ///  name                              "America/New_York"
            ///  offsetSec                        -18000  som er -5 timer i forhold til UTC
            ///  offsetString                     " -0500" som er -5 timer i forhold til UTC
            ///  shortTimezone                "EST"
            ///
            
            if openCage.results[i].annotations.timezone.name != nil {
                geoRecord.name = openCage.results[i].annotations.timezone.name!
            } else {
                geoRecord.name = ""
            }

            if openCage.results[i].annotations.timezone.nowInDST != nil {
                geoRecord.dst = openCage.results[i].annotations.timezone.nowInDST!
            } else {
                geoRecord.dst = 0
            }

            if openCage.results[i].annotations.timezone.offsetSec != nil {
                geoRecord.offsetSec = openCage.results[i].annotations.timezone.offsetSec!
            } else {
                geoRecord.offsetSec = 0
            }

            if openCage.results[i].annotations.timezone.offsetString != nil {
                geoRecord.offsetString = openCage.results[i].annotations.timezone.offsetString!
            } else {
                geoRecord.offsetString = ""
            }

            if openCage.results[i].annotations.timezone.shortName != nil {
                geoRecord.dst = openCage.results[i].annotations.timezone.nowInDST!
            } else {
                geoRecord.dst = 0
            }

            if openCage.results[i].annotations.timezone.shortName != nil {
                geoRecord.zoneShortName = openCage.results[i].annotations.timezone.shortName!
            } else {
                geoRecord.zoneShortName = ""
            }

            if openCage.results[i].annotations.timezone.shortName != nil {
                geoRecord.zoneName = openCage.results[i].annotations.timezone.name!
            } else {
                geoRecord.zoneName = ""
            }

            geoRecords = geoRecord
            
        }
        return geoRecords
    }
    catch {
        debugPrint(error)
        return geoRecords
    }
    
}
