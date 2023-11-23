//
//  FindChartDataProbability.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataProbability(date: Date) -> [NewProbability] {
    let value : (Date,Date) = DateRange(date: date)
    var i: Int = 0
    var nData = NewProbability(type: "", hour: 0, value: 0.00)
    var newProbability : [NewProbability] = []
    newProbability.removeAll()
    hourForecast!.forEach  {
        if $0.date >= value.0 &&
            $0.date < value.1 {
            if $0.precipitation.description.count > 0 {
                nData.type = $0.precipitation.description.firstUppercased
//            } else {
//                nData.type = String(localized: "None")
            }
            nData.hour = i
            ///
            /// The value is from `0` (0% probability) to `1` (100% probability).
            ///
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            if $0.precipitationChance > 0.00 {
                nData.value = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
            } else {
                nData.value = 0.00
            }
            newProbability.append(nData)
            i = i + 1
        }
    }
    return newProbability
}
