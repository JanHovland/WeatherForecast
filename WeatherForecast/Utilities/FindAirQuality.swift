//
//  FindAirQuality.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/10/2023.
//

import Foundation
import SwiftUI


func FindAirQuality(url: String,
                    key: String,
                    latitude : Double,
                    longitude: Double)  async -> (LocalizedStringKey, AirQualityRecord) {
    
    var airQualityRecord = AirQualityRecord()
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    
    let urlString1 = url + "lat=" + "\(latitude)" + "&lon=" + "\(longitude)" + "&appid="  + "\(key)"
    let urlString = urlString1.replacingOccurrences(of: " ", with: "")
    let url = URL(string: urlString)
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
                let airQuality = try? JSONDecoder().decode(AirQuality.self, from: jsonData)
                
                airQualityRecord.aqi = airQuality?.list[0].main.aqi ?? 0
                airQualityRecord.co = airQuality?.list[0].components.co ?? 0.00
                airQualityRecord.no = airQuality?.list[0].components.no ?? 0.00
                airQualityRecord.no2 = airQuality?.list[0].components.no2 ?? 0.00
                airQualityRecord.o3 = airQuality?.list[0].components.o3 ?? 0.00
                airQualityRecord.so2 = airQuality?.list[0].components.so2 ?? 0.00
                airQualityRecord.pm2_5 = airQuality?.list[0].components.pm2_5 ?? 0.00
                airQualityRecord.pm10 = airQuality?.list[0].components.pm10 ?? 0.00
                airQualityRecord.nh3 = airQuality?.list[0].components.nh3 ?? 0.00
                airQualityRecord.dt =  airQuality?.list[0].dt ?? 0
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
    
    return (errorMessage, airQualityRecord)
}
