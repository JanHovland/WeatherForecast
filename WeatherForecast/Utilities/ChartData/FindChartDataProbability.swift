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
                              index: Int,
                              latitude: Double,
                              longitude: Double) async -> ([NewProbability],
                                              Double,
                                              Int,
                                              Double,
                                              Int, 
                                              PrecificationLast24h,
                                              PrecificationNext24h) {
    
    let value : (Date,Date) = DateRange(date: date)
    var i: Int = 0
    var nData = NewProbability(type: "", hour: 0, value: 0.00)
    var newProbability : [NewProbability] = []
    var min: Double = 0.00
    var minIndex: Int = 0
    var max: Double = 0.00
    var maxIndex: Int = 0
    var precificationLast24h = PrecificationLast24h()
    var precificationNext24h = PrecificationNext24h()
    
    var hourForecastLast: Forecast<HourWeather>?
    var hourForecastNext: Forecast<HourWeather>?
    
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
    
    print("index = \(index)")
    
    ///
    /// Tilpasser datoen idag, for 24t siden og 24t frem i tid
    ///
    let toDay = date.adding(hours: GetCurrentDeviationHursFromUTC()).setTime(hour: GetHourFromDate(date: Date()), min: 0, sec: 0)!
    let fromLast24 = toDay.adding(days: -1)
    let toNext24 = toDay.adding(days: 1)
    let location = CLLocation(latitude: latitude, longitude: longitude)
    do {
        hourForecastLast = try await WeatherService.shared.weather(for: location,
                                                                       including: .hourly(startDate: fromLast24,
                                                                                          endDate: toDay))
    } catch {
        debugPrint(error)
    }
    ///
    /// Finner nedbøren de siste 24 timene
    ///
    hourForecastLast!.forEach  {
        if $0.date >= fromLast24 &&
            $0.date < toDay {
            print($0.date)
            if $0.precipitation.description.firstUppercased == String(localized: "Rain ") {
                precificationLast24h.rainLast24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                precificationLast24h.snowLast24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                precificationLast24h.hailLast24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                precificationLast24h.mixedLast24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                precificationLast24h.sleetLast24 += $0.precipitationAmount.value
            }
        }
    }
    ///
    /// Finner nedbøren de neste 24 timene
    ///
    do {
        hourForecastNext = try await WeatherService.shared.weather(for: location,
                                                                   including: .hourly(startDate: toDay,
                                                                                      endDate: toNext24))
    } catch {
        debugPrint(error)
    }
    hourForecastNext!.forEach  {
        if $0.date >= toDay &&
            $0.date < toNext24 {
            if $0.precipitation.description.firstUppercased == String(localized: "Rain ") {
                precificationNext24h.rainNext24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Snow") {
                precificationNext24h.snowNext24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Hail") {
                precificationNext24h.hailNext24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Mixed") {
                precificationNext24h.mixedNext24 += $0.precipitationAmount.value
            } else if $0.precipitation.description.firstUppercased == String(localized: "Sleet") {
                precificationNext24h.sleetNext24 += $0.precipitationAmount.value
            }
        }
    }
    
    return (newProbability, 
            min,
            minIndex,
            max,
            maxIndex,
            precificationLast24h,
            precificationNext24h)
}
