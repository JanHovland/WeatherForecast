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
                                                     AverageMonthlyDataRecord) {
    
    var errorMessage: LocalizedStringKey = ""
    var httpStatus: Int = 0
    var averageMonthlyDataRecord = AverageMonthlyDataRecord(time: [""],
                                                            precipitationSum: [0.00],
                                                            temperature2MMin: [0.00],
                                                            temperature2MMax: [0.00],
                                                            temperature2MMean: [0.00])
     
    ///
    /// Dokumentasjon: https://open-meteo.com/en/docs/historical-weather-api
    ///
    let urlSession = URLSession.shared
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
    do {
        let (jsonData, response) = try await urlSession.data(from: url!)
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
        if httpStatus >= 400,
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
            if let data = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData) {
                ///
                /// Oppdatering av averageMonthlyDataRecord
                ///
                averageMonthlyDataRecord.time = (data.daily.time)
                averageMonthlyDataRecord.precipitationSum = (data.daily.precipitationSum)
                averageMonthlyDataRecord.temperature2MMin = (data.daily.temperature2MMin)
                averageMonthlyDataRecord.temperature2MMax = (data.daily.temperature2MMax)
                averageMonthlyDataRecord.temperature2MMean = (data.daily.temperature2MMean)
                
                
                logger.notice("\(averageMonthlyDataRecord.time)")
                logger.notice("\(averageMonthlyDataRecord.precipitationSum)")

                ///
                /// Find average yearly data
                ///
                (averageMonthMin,
                 averageMonthMax,
                 averageMonthMean,
                 averageMonthPrecification) = FindAverageYear(averageDailyTime: averageMonthlyDataRecord.time,
                                                              avarageDailyMin: averageMonthlyDataRecord.temperature2MMin,
                                                              avarageDailyMax: averageMonthlyDataRecord.temperature2MMax,
                                                              averageDailyMean: averageMonthlyDataRecord.temperature2MMean,
                                                              aveargePercification: averageMonthlyDataRecord.precipitationSum)
                
                logger.notice("\(averageMonthPrecification)")
            }
        }
    } catch {
        debugPrint(error)
    }
    ///
    /// Returnerer data
    ///
    return (errorMessage, averageMonthlyDataRecord)
}

