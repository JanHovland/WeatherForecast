//
//  FindAirQuality.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/10/2023.
//

import Foundation


/// https://api.openweathermap.org/data/2.5/air_pollution?lat=50&lon=50&appid=

func FindAirQuality(url: String,
                    key: String,
                    latitude : Double,
                    longitude: Double)  async -> (String, AirQualityRecord) {
    
    var airQualityRecord = AirQualityRecord()
    
    var errors : String = ""
    
    let urlString1 = url + "lat=" + "\(latitude)" + "&lon=" + "\(longitude)" + "&appid="  + "\(key)"
    let urlString = urlString1.replacingOccurrences(of: " ", with: "")
    let url = URL(string: urlString)
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, _) = try await urlSession.data(from: url)
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
        } catch {
            errors = "\(error)"
        }
    }
    return (errors, airQualityRecord)
}
