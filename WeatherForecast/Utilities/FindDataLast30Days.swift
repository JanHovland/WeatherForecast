//
//  FindPrecipitationLast30Days.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/03/2024.
//

import SwiftUI

func FindDataLast30Days(placeName: String,
                        lat: Double?,
                        lon: Double?) async -> (LocalizedStringKey,
                                                String,
                                                String,
                                                AverageDailyDataRecord) {
    
    var errorMessage: LocalizedStringKey = ""
    ///
    /// Finner fromDate som er dagen i dag minus 1 dag
    ///
    let yesterDay = GetLocalDate(date: Date()).adding(days: -1)
    let dayTo = FormatDateToString(date: yesterDay, format: "yyyy-MM-dd", offsetSec: 0)
    ///
    /// Finner fromDate som er 30 dager bakover i tid
    ///
    let fromDate = yesterDay.adding(days: -29)
    let dayFrom = FormatDateToString(date: fromDate, format: "yyyy-MM-dd", offsetSec: 0)
    
    (errorMessage, average30DaysDataRecord) = await GetAverageDayWeather(option: .days,
                                                                         placeName: placeName,
                                                                         years: 0,
                                                                         startDate: dayFrom,
                                                                         endDate: dayTo,
                                                                         lat: lat ?? 0.00,
                                                                         lon: lon ?? 0.00)
    
    let expTo = FormatDateToString(date: yesterDay, format: "-MM-dd", offsetSec: 0)
    let expFrom = FormatDateToString(date: fromDate, format: "-MM-dd", offsetSec: 0)

    return (errorMessage, expFrom, expTo, average30DaysDataRecord)
}

