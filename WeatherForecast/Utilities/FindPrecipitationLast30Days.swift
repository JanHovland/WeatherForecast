//
//  FindPrecipitationLast30Days.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/03/2024.
//

import SwiftUI

func FindPrecipitationLast30Days(averageDataRecord: AverageDataRecord,
                                 offset: Int) -> Double {
    
    var amountPrecification: Double = 0.00
    ///
    /// Finner fromDate som er dagen i dag minus 1 dag
    ///
    let yesterDay = GetLocalDate(date: Date()).adding(days: -1)
    ///
    /// Finner fromDate som er 30 dager bakover i tid
    ///
    let fromDate = yesterDay.adding(days: -30)
    ///
    /// Finner toDate som er testerDay
    ///
    let toDate = yesterDay
    ///
    /// Finner sum av nedbøren de siste 30 dagene
    ///
    for i in 0..<averageDataRecord.time.count {
        for j in 0..<30 {
            let day = FormatDateToString(date: fromDate.adding(days: j), format: "yyyy-MM-dd", offsetSec: -3600)
            if averageDataRecord.time[i] == day {
                amountPrecification += averageDataRecord.precipitationSum[i] ?? 0.00
            }
        }
    }
    return (amountPrecification)
}
