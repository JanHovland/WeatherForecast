//
//  FindMoonUpDown.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import Foundation


func FindMoonUpDown(url: String,
                    key: String,
                    latitude : Double?,
                    longitude: Double?) async -> (String, MoonRecord) {
    
    var errors : String = ""
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
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, _) = try await urlSession.data(from: url)
            let metApiMoon = try? JSONDecoder().decode(WeatherApiMoon.self, from: jsonData)
            debugPrint(metApiMoon as Any)
            ///
            /// Oppdaterer moonRecord:
            ///
            moonRecord.moonrise = metApiMoon?.astronomy.astro.moonrise ?? ""
            moonRecord.moonset = metApiMoon?.astronomy.astro.moonset ?? ""
            moonRecord.moonPhase = metApiMoon?.astronomy.astro.moonPhase ?? ""
            
            if moonRecord.moonPhase == "Last Quarter" {
                moonRecord.moonPhase = String(localized: "Last Quarter")
            }
            moonRecord.moonIllumination = metApiMoon?.astronomy.astro.moonIllumination ?? 0
            moonRecord.isMoonUp = metApiMoon?.astronomy.astro.isMoonUp ?? 0
            moonRecord.isSunUp = metApiMoon?.astronomy.astro.isSunUp ?? 0
        } catch {
            errors = "\(error)"
        }
    }
    return (errors, moonRecord)
}
