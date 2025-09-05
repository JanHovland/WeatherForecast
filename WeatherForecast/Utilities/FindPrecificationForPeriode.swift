//
//  FindPrecificationForPeriode.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/04/2024.
//

import Foundation

func FindPrecificationForPeriode(averageYearsDataRecord: AverageDailyDataRecord,
                                 year: String,
                                 fromDate: String,
                                 toDate: String) -> Double {
    
    var precification: Double = 0.00
    let from = year + fromDate
    let to = year + toDate
    precification = 0.00
    for i in 0..<averageYearsDataRecord.time.count {
        if averageYearsDataRecord.time[i] >= from,
           averageYearsDataRecord.time[i] <= to {
            precification += averageYearsDataRecord.precipitationSum[i] ?? 0.00
        }
    }
    
    return precification
}
