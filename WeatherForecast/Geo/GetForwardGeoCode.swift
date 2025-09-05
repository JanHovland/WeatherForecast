//
//  GetForwardGeoCode.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/09/2022.
//

import Foundation 

func GetForwardGeoCode(place: String, key: String, urlOpenCage: String) async -> ([GeoRecord]) {
    
    var openCage = OpenCage()
    var geoRecords = [GeoRecord]()
    
    let url = URL(string: urlOpenCage + formatPlace(place: place) + "&key=" + key)
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
            if geoRecord.type == "police" { geoRecord.type = String(localized: "police") }
            if geoRecord.type == "shop" { geoRecord.type = String(localized: "butikk") }
            if geoRecord.type == "ferry_terminal" { geoRecord.type = String(localized: "ferry_terminal") }
            if geoRecord.type == "bar" { geoRecord.type = String(localized: "bar") }
            if geoRecord.type == "municipality" { geoRecord.type = String(localized: "municipality") }
            if geoRecord.type == "water" { geoRecord.type = String(localized: "water") }
            if geoRecord.type == "bus_stop" { geoRecord.type = String(localized: "bus_stop") }
            if geoRecord.type == "information" { geoRecord.type = String(localized: "information") }
            if geoRecord.type == "peak" { geoRecord.type = String(localized: "peak") }


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
            if openCage.results[i].components.category != nil {
                geoRecord.category = openCage.results[i].components.category!
            }
            if openCage.results[i].components.continent != nil {
                geoRecord.continent = openCage.results[i].components.continent!
            }
            if openCage.results[i].components.country != nil {
                geoRecord.country = openCage.results[i].components.country!
            }
            if openCage.results[i].components.countryCode != nil {
                geoRecord.countryCode = openCage.results[i].components.countryCode!
            }
            if openCage.results[i].components.county != nil {
                geoRecord.county = openCage.results[i].components.county!
            }
            if openCage.results[i].components.municipality != nil {
                geoRecord.municipality = openCage.results[i].components.municipality!
            }
            if openCage.results[i].components.municipality != nil {
                geoRecord.municipality = openCage.results[i].components.municipality!
            }
            if openCage.results[i].components.postalCity != nil {
                geoRecord.postalCity = openCage.results[i].components.postalCity!
            }
            if openCage.results[i].components.postcode != nil {
                geoRecord.postcode = openCage.results[i].components.postcode!
            }
            if openCage.results[i].components.village != nil {
                geoRecord.village = openCage.results[i].components.village!
            }
            if openCage.results[i].components.hamlet != nil {
                geoRecord.hamlet = openCage.results[i].components.hamlet!
            }
            if openCage.results[i].components.neighbourhood != nil {
                geoRecord.neighbourhood = openCage.results[i].components.neighbourhood!
            }
            if openCage.results[i].components.city != nil {
                geoRecord.city = openCage.results[i].components.city!
            }
            if openCage.results[i].components.town != nil {
                geoRecord.town = openCage.results[i].components.town!
            }
            if openCage.results[i].components.state != nil {
                geoRecord.state = openCage.results[i].components.state!
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

            if openCage.results[i].annotations.timezone.nowInDST != nil {
                geoRecord.dst = openCage.results[i].annotations.timezone.nowInDST!
            } else {
                geoRecord.dst = 0
            }

            if openCage.results[i].annotations.timezone.shortName != nil {
                geoRecord.zoneName = openCage.results[i].annotations.timezone.name!
            } else {
                geoRecord.zoneName = ""
            }

            if openCage.results[i].annotations.timezone.name != nil {
                geoRecord.zoneShortName = openCage.results[i].annotations.timezone.shortName!
            } else {
                geoRecord.zoneShortName = ""
            }

            geoRecords.append(geoRecord)
            geoRecords.sort(by: {$0.flag > $1.flag})
        }
        return geoRecords
    }
    catch {
        debugPrint(error)
        return geoRecords
    }
}

