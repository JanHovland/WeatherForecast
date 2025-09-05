//
//  GetAverageDailyWeatherYears.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/04/2024.
//

import SwiftUI

func GetAverageDailyWeatherYears(startDate: String,
                                lat: Double,
                                lon: Double) async -> (LocalizedStringKey,
                                                       AverageDailyYearDataRecord) {
    
    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    
    var averageDailyYearDataRecord = AverageDailyYearDataRecord(time: [""],
                                                                precipitationSum:
                                                                    [0.00])
    let toDate: String = "2020-12-31"
    
    let part1 = UserDefaults.standard.object(forKey: "Url1OpenMeteo") as? String ?? ""
    
    let urlString = part1 + "\(lat)" +
                    "&longitude=" + "\(lon)" + "&timezone=auto" + "&daily=precipitation_sum" +
                    "&start_date=" + startDate + "&end_date=" + toDate
    
    let url = URL(string: urlString)
    ///
    /// Henter gjennomsnittsdata
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
            ///
            /// 200 OK
            /// The request succeeded.
            ///
            /// 400 Bad Request
            /// The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
            ///
            if httpStatus > 200,
               httpStatus <= 499 {
                if httpStatus == 400 {
                    let msg = String(localized: "400 = Bad Request")
                    errorMessage = LocalizedStringKey(msg)
                } else if httpStatus == 429 {
                    let msg = String("429 = Too Many Requests, the user has sent too many requests in a given amount of time (\"rate limiting\")")
                    errorMessage = LocalizedStringKey(msg)
                } else {
                    let msg = "\(httpStatus)"
                    errorMessage = LocalizedStringKey(msg)
                }
            } else {
                if let averageData = try? JSONDecoder().decode(AverageDailyYearData.self, from: jsonData) {
                    ///
                    /// Oppdatering av averageHourlyYearDataRecord
                    ///
                    averageDailyYearDataRecord.time = averageData.daily.time
                    averageDailyYearDataRecord.precipitationSum = averageData.daily.precipitationSum ?? [0.00]
                    let msg = String(localized: "Can not find any average data")
                    errorMessage = LocalizedStringKey(msg)
                }
            }
        } catch {
            debugPrint(error)
        }
    }
    
    return (errorMessage, averageDailyYearDataRecord)
}
    
