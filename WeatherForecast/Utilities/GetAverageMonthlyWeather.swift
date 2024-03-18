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
    logger.notice("Start fetch")
    let url = URL(string: urlString)
    ///
    /// Henter gjennomsnittsdata
    ///
    do {
        let (jsonData, _) = try await urlSession.data(from: url!)
        if let data = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData) {
            ///
            /// Oppdatering av averageMonthlyDataRecord
            ///
            averageMonthlyDataRecord.time = (data.daily.time)
            averageMonthlyDataRecord.precipitationSum = (data.daily.precipitationSum)
            averageMonthlyDataRecord.temperature2MMin = (data.daily.temperature2MMin)
            averageMonthlyDataRecord.temperature2MMax = (data.daily.temperature2MMax)
            averageMonthlyDataRecord.temperature2MMean = (data.daily.temperature2MMean)
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
            
        } else {
            errorMessage = "Nil data from JSONDecoder."
        }
    } catch {
        debugPrint(error)
    }
    ///
    /// Returnerer data
    ///
    return (errorMessage, averageMonthlyDataRecord)
}


