//
//  GetAverageMonthlyWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/03/2024.
//

import Foundation
import SwiftUI

func GetAverageMonthlyWeather(urlPart1: String,
                              urlPart2: String,
                              startDate: String,
                              endDate: String,
                              lat: Double,
                              lon: Double) async -> (LocalizedStringKey,
                                                     AverageDataRecord) {
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    var averageDataRecord = AverageDataRecord(time: [""],
                                              precipitationSum: [0.00],
                                              temperature2MMin: [0.00],
                                              temperature2MMax: [0.00],
                                              temperature2MMean: [0.00])
    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    /// Husk å sette timezone=auto for å riktig tidssone
    ///
    let urlString =
    urlPart1 + "\(lat)" + "&longitude=" + "\(lon)" + urlPart2 + "&start_date=" + startDate + "&end_date=" + endDate
    logger.notice("urlString = \(urlString)")
    let url = URL(string: urlString)
    ///
    /// Henter gjennomsnittsdata
    ///
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, response) = try await urlSession.data(from: url)
            
            logger.notice("\(jsonData)")
            
            ///
            /// Finner statusCode fra response
            ///
            let res = response as? HTTPURLResponse
            httpStatus = res!.statusCode
            logger.notice("response = \(res!.statusCode)")
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
                    logger.notice("\(msg)")
                    errorMessage = LocalizedStringKey(msg)
                } else if httpStatus == 429 {
                    let msg = String("429 = Too Many Requests, the user has sent too many requests in a given amount of time (\"rate limiting\")")
                    logger.notice("\(msg)")
                    errorMessage = LocalizedStringKey(msg)
                } else {
                    let msg = "\(httpStatus)"
                    logger.notice("\(httpStatus)")
                    errorMessage = LocalizedStringKey(msg)
                }
            } else {
                if let averageData = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData) {
                    
                    logger.notice("averageData = \(String(describing: averageData))")
                    ///
                    /// Oppdatering av averageMonthlyDataRecord
                    ///
                    averageDataRecord.time = (averageData.daily.time)
                    averageDataRecord.precipitationSum = (averageData.daily.precipitationSum)
                    averageDataRecord.temperature2MMin = (averageData.daily.temperature2MMin)
                    averageDataRecord.temperature2MMax = (averageData.daily.temperature2MMax)
                    averageDataRecord.temperature2MMean = (averageData.daily.temperature2MMean)
                    
                    
                    logger.notice("\(averageDataRecord.time)")
                    logger.notice("\(averageDataRecord.precipitationSum)")
                    logger.notice("\(averageDataRecord.temperature2MMin)")
                    logger.notice("\(averageDataRecord.temperature2MMax)")
                    logger.notice("\(averageDataRecord.temperature2MMean)")

                    //                ///
                    //                /// Find average yearly data
                    //                ///
                    //                (averageMonthMin,
                    //                 averageMonthMax,
                    //                 averageMonthMean,
                    //                 averageMonthPrecification) = FindAverageYear(averageDailyTime: averageDataRecord.time,
                    //                                                              avarageDailyMin: averageDataRecord.temperature2MMin,
                    //                                                              avarageDailyMax: averageDataRecord.temperature2MMax,
                    //                                                              averageDailyMean: averageDataRecord.temperature2MMean,
                    //                                                              aveargePercification: averageDataRecord.precipitationSum)
                    //
                    //                logger.notice("\(averageMonthPrecification)")
                    //            }
                    //        }
                } else {
                    let msg = String(localized: "Can not find any average data")
                    logger.notice("\(msg)")
                    errorMessage = LocalizedStringKey(msg)
                }
            }
        } catch {
            debugPrint(error)
        }
    }
    ///
    /// Returnerer data
    ///
    return (errorMessage, averageDataRecord)
}

