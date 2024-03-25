//
//  FindPrecipitationLast30Days.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/03/2024.
//

import SwiftUI


func FindPrecipitationLast30Days(averageDataRecord: AverageDataRecord,
                                 fromDays: Int,
                                 toDays: Int,
                                 offset: Int) -> Double {
    
    var amount: Double = 0.00
    ///
    /// Finner fromDate som er dagen i dag minus 1 dag
    ///
    let yesterDay = GetLocalDate(date: Date()).adding(days: -1)
    ///
    /// Finner fromDate som er 30 dager bakover i tid
    ///
    let fromDate = yesterDay.adding(days: fromDays)
    ///
    /// Finner toDate som er testerDay
    ///
    let toDate = yesterDay
    
    logger.notice("\(fromDate) \(toDate)")

    amount = 0.00
    
    return amount
}
