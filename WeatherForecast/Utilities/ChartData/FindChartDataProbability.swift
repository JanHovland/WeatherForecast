//
//  FindChartDataProbability.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataProbability(date: Date) -> ([NewProbability],
                                              Double,
                                              Int,
                                              Double,
                                              Int, 
                                              PrecificationData) {
    
    let value : (Date,Date) = DateRange(date: date)
    var i: Int = 0
    var nData = NewProbability(type: "", hour: 0, value: 0.00)
    var newProbability : [NewProbability] = []
    
    var min: Double = 0.00
    var minIndex: Int = 0
    var max: Double = 0.00
    var maxIndex: Int = 0
    
    var precificationData = PrecificationData()
    
    newProbability.removeAll()
    
    hourForecast!.forEach  {
        if $0.date >= value.0 &&
            $0.date < value.1 {
            if $0.precipitation.description.count > 0 {
                nData.type = $0.precipitation.description.firstUppercased
            }
            nData.hour = i
            ///
            /// The value is from `0` (0% probability) to `1` (100% probability).
            ///
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            if $0.precipitationChance > 0.00 {
                
                if i == 0 {
                    min = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
                    minIndex = i
                    max = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
                    maxIndex = i
                } else {
                    if $0.precipitationChance > max {
                        max = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
                        maxIndex = i
                    }
                    if $0.precipitationChance < min {
                        min = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
                        minIndex = i
                    }
                }
                nData.value = Double(formatter.string(from: $0.precipitationChance * 100.00 as NSNumber)!)!
            } else {
                nData.value = 0.00
            }
            newProbability.append(nData)
            ///
            /// Finner precificationData
            ///
            if $0.precipitation.description.firstUppercased == String(localized: "Rain") {
                precificationData.rain = precificationData.rain + $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                precificationData.snow = precificationData.snow + $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                precificationData.hail = precificationData.hail + $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                precificationData.mixed = precificationData.mixed + $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                precificationData.sleet = precificationData.sleet + $0.precipitationAmount.value
            }
            i = i + 1
        }
    }
    return (newProbability, min, minIndex, max, maxIndex, precificationData)
}
