//
//  FindChartDataProbability.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

func FindChartDataProbability(date: Date,
                              index: Int) -> ([NewProbability],
                                              Double,
                                              Int,
                                              Double,
                                              Int,
                                              Precification) {
    
    let value : (Date,Date) = DateRange(date: date)
    var i: Int = 0
    var nData = NewProbability(type: "", hour: 0, value: 0.00)
    var newProbability : [NewProbability] = []
    var min: Double = 0.00
    var minIndex: Int = 0
    var max: Double = 0.00
    var maxIndex: Int = 0
    var precification = Precification()
    
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
            i = i + 1
        }
    }
    if index == 0 {
        ///
        /// Tilpasser datoen idag, for 24t siden og 24t frem i tid
        ///
        let toDay = date.adding(hours: GetCurrentDeviationHursFromUTC()).setTime(hour: GetHourFromDate(date: Date()), min: 0, sec: 0)!
        let fromLast24 = toDay.adding(days: -1)
        let toNext24 = toDay.adding(days: 1)
        ///
        /// Finner nedbøren de siste 24 timene
        ///
        hourForecast!.forEach  {
            if $0.date >= fromLast24 &&
                $0.date <  toDay {
                if $0.precipitation.description.firstUppercased == String(localized: "Rain ") {
                    precification.rainLast24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                    precification.snowLast24 += $0.precipitationAmount.value * 10.0
                } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                    precification.hailLast24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                    precification.mixedLast24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                    precification.sleetLast24 += $0.precipitationAmount.value
                }
            }
        }
        ///
        /// Finner nedbøren de neste 24 timene
        ///
        hourForecast!.forEach  {
            if $0.date >= toDay &&
                $0.date < toNext24 {
                if $0.precipitation.description.firstUppercased == String(localized: "Rain ") {
                    precification.rainNext24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                    precification.snowNext24 += $0.precipitationAmount.value * 10.0
                } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                    precification.hailNext24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                    precification.mixedNext24 += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                    precification.sleetNext24 += $0.precipitationAmount.value
                }
            }
        }
    } else {
        ///
        /// Dtoen er avhengig av index
        ///
        let fromDate = date.setTime(hour: 0, min: 0, sec: 0)!
        let toDate = fromDate.adding(days: 1)
 
        hourForecast!.forEach  {
            if $0.date >= fromDate &&
                $0.date < toDate {
                if $0.precipitation.description.firstUppercased == String(localized: "Rain ") {
                    precification.rainThisDay += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                    precification.snowThisDay += $0.precipitationAmount.value * 10.0
                } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                    precification.hailThisDay += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                    precification.mixedThisDay += $0.precipitationAmount.value
                } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                    precification.sleetThisDay += $0.precipitationAmount.value
                }
            }
        }
    }
    
    return (newProbability, 
            min,
            minIndex,
            max,
            maxIndex,
            precification)
}
