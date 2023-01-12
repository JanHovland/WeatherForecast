//
//  GetForwardGeoCode.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/09/2022.
//

import Foundation 

func getForwardGeoCode(place: String, key: String, urlOpenCage: String) async -> ([GeoRecord]) {
    
    var openCage = OpenCage()
    var geoRecords = [GeoRecord]()
    
    let url = URL(string: urlOpenCage + formatPlace(place: place) + "&key=" + key)
    print(url as Any)
    let urlSession = URLSession.shared
    
    do {
        let (data, _) = try await urlSession.data(from: url!)
        openCage = try JSONDecoder().decode(OpenCage.self, from: data)
        let count = openCage.results.count
        for i in 0..<count {
            var geoRecord = GeoRecord()
            geoRecord.searchString = place
            if openCage.results[i].annotations.flag != nil {
                geoRecord.flag = openCage.results[i].annotations.flag!
            } else {
                geoRecord.flag = "🏳️"
            }
            if openCage.results[i].components.type != nil {
                geoRecord.type = openCage.results[i].components.type!
            } else {
                geoRecord.type = ""
            }
            
            if geoRecord.type == "city" { geoRecord.type = String(localized: "city") }
            if geoRecord.type == "railway" { geoRecord.type = String(localized: "railway") }
            if geoRecord.type == "village" { geoRecord.type = String(localized: "village") }
            if geoRecord.type == "hotel" { geoRecord.type = String(localized: "hotel") }
            if geoRecord.type == "hamlet" { geoRecord.type = String(localized: "hamlet") }
            if geoRecord.type == "farm" { geoRecord.type = String(localized: "farm") }
            if geoRecord.type == "place_of_worship" { geoRecord.type = String(localized: "place_of_worship") }
            if geoRecord.type == "body_of_water" { geoRecord.type = String(localized: "body_of_water") }
            if geoRecord.type == "building" { geoRecord.type = String(localized: "building") }
            if geoRecord.type == "continent" { geoRecord.type = String(localized: "continent") }
            if geoRecord.type == "country" { geoRecord.type = String(localized: "country") }
            if geoRecord.type == "county" { geoRecord.type = String(localized: "county") }
            if geoRecord.type == "fictitious" { geoRecord.type = String(localized: "fictitious") }
            if geoRecord.type == "island" { geoRecord.type = String(localized: "island") }
            if geoRecord.type == "neighbourhood" { geoRecord.type = String(localized: "neighbourhood") }
            if geoRecord.type == "partial_postcode" { geoRecord.type = String(localized: "partial_postcode") }
            if geoRecord.type == "postal_city" { geoRecord.type = String(localized: "postal_city") }
            if geoRecord.type == "postcode" { geoRecord.type = String(localized: "postcode") }
            if geoRecord.type == "region" { geoRecord.type = String(localized: "region") }
            if geoRecord.type == "road" { geoRecord.type = String(localized: "road") }
            if geoRecord.type == "state" { geoRecord.type = String(localized: "state") }
            if geoRecord.type == "state_district" { geoRecord.type = String(localized: "state_district") }
            if geoRecord.type == "terminated_postcode" { geoRecord.type = String(localized: "terminated_postcode") }
            if geoRecord.type == "unknown" { geoRecord.type = String(localized: "unknown") }
            if geoRecord.type == "waterway" { geoRecord.type = String(localized: "waterway") }
            if geoRecord.type == "craft" { geoRecord.type = String(localized: "craft") }
            if geoRecord.type == "boundary_stone" { geoRecord.type = String(localized: "boundary_stone") }


            if openCage.results[i].formatted != nil {
                let formatted = String(openCage.results[i].formatted!.prefix(40))
                geoRecord.formatted = formatted
            } else {
                geoRecord.formatted = ""
            }
            if openCage.results[i].geometry.lat != nil {
                geoRecord.latitude = openCage.results[i].geometry.lat!
            }
            if openCage.results[i].geometry.lng != nil {
                geoRecord.longitude = openCage.results[i].geometry.lng!
            }
            geoRecords.append(geoRecord)
        }
        return geoRecords
    }
    catch {
        debugPrint(error)
        return geoRecords
    }
}

