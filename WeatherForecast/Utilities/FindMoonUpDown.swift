//
//  FindMoonUpDown.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import Foundation
import SwiftUI

func FindMoonUpDown(url: String,
                    key: String,
                    latitude : Double?,
                    longitude: Double?) async -> (LocalizedStringKey, MoonRecord) {
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    var lat: String = ""
    var lon: String = ""
    var moonRecord = MoonRecord()
    
    if latitude != nil {
        lat = "\(latitude!)"
    } else {
        lat = "\(58.618050)" /// Varhaug
    }
    if longitude != nil {
        lon = "\(longitude!)"
    } else {
        lon = "\(5.655520)"  /// Varhaug
    }
    let urlString = url + "key=" + key + "&q=" + "\(lat),\(lon)"
    let url = URL(string: urlString)
    ///
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, response) = try await urlSession.data(from: url)
            ///
            /// Finner statusCode fra response
            ///
            let res = response as? HTTPURLResponse
            httpStatus = res!.statusCode

            if httpStatus == 200 {
                let metApiMoon = try? JSONDecoder().decode(WeatherApiMoon.self, from: jsonData)
                ///
                /// Oppdaterer moonRecord:
                ///
                moonRecord.moonrise = metApiMoon?.astronomy.astro.moonrise ?? ""
                moonRecord.moonset = metApiMoon?.astronomy.astro.moonset ?? ""
                moonRecord.moonPhase = metApiMoon?.astronomy.astro.moonPhase ?? ""
                /// https://moonphases.co.uk/moon-phases
                /// <a href="http://moonphases.co.uk/moon-phases"><img src="http://moonphases.co.uk/images/infographic.png" alt="Moon Phases" /></a>
                
                if moonRecord.moonPhase == "Last Quarter" {
                    moonRecord.moonPhase = String(localized: "Last Quarter")
                } else if moonRecord.moonPhase == "Waning Crescent" {
                    moonRecord.moonPhase = String(localized: "Waning Crescent")
                } else if moonRecord.moonPhase == "New Moon" {
                    moonRecord.moonPhase = String(localized: "New Moon")
                } else if moonRecord.moonPhase == "Waxing Crescent" {
                    moonRecord.moonPhase = String(localized: "Waxing Crescent")
                } else if moonRecord.moonPhase == "First Quarter" {
                    moonRecord.moonPhase = String(localized: "First Quarter")
                } else if moonRecord.moonPhase == "Waxing Gibbous" {
                    moonRecord.moonPhase = String(localized: "Waxing Gibbous")
                } else if moonRecord.moonPhase == "Full Moon" {
                    moonRecord.moonPhase = String(localized: "Full Moon")
                } else if moonRecord.moonPhase == "Waning Gibbous" {
                    moonRecord.moonPhase = String(localized: "Waning Gibbous")
                }
                moonRecord.moonIllumination = metApiMoon?.astronomy.astro.moonIllumination ?? 0
                moonRecord.isMoonUp = metApiMoon?.astronomy.astro.isMoonUp ?? 0
                moonRecord.isSunUp = metApiMoon?.astronomy.astro.isSunUp ?? 0
            } else {
                ///
                /// Returnerer errorMessage
                ///
                errorMessage = ServerResponse(error:"\(response)")
            }
        } catch {
            ///
            /// Returnerer errorMessage
            ///
            let response = CatchResponse(response: "\(error)",
                                         searchFrom: "Code=",
                                         searchTo: "UserInfo")
            errorMessage = "\(response)"
        }
    }
    return (errorMessage, moonRecord)
}
