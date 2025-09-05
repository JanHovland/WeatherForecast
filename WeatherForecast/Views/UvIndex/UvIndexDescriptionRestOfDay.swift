//
//  UvIndexDescriptionRestOfDay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/11/2022.
//

import SwiftUI
import WeatherKit

func UvIndexDescriptionRestOfDay(weather: Weather) -> String {
    
    var array : [Double] = Array(repeating: Double(), count: sizeArray24)
    let value : (Date,Date) = DateHourRange(date: weather.currentWeather.date)
    
    weather.hourlyForecast.forEach  {
        if $0.date >= value.0 &&
            $0.date < value.1 {
            array.append(Double($0.uvIndex.value)) /// uvIndex er en Int
        }
    }
    
    let uvIndex = Int(array.max()!)
    
    switch uvIndex {
    case 0...2:
        return String(localized: "Low level for the rest of the day.")
    case 3...5:
        return String(localized: "Can be moderate levels today.")
    case 6...7:
        return String(localized: "Can be high levels today.")
    case 8...10:
        return String(localized: "Can be very high levels today.")
    default:
        return String(localized: "Can be extreme levels today.")
    }
}
