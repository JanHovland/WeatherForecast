//
//  DayDetailFunctions.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2022.
//

import SwiftUI
import WeatherKit


func createDateArray (weather: Weather) -> [String] {
    
    var dates = [String]()
    
    weather.dailyForecast.forEach {
        dates.append(FormatDateToString(date: $0.date, format: "d"))
    }
    
    return dates
}

func createWeekdayArray (weather: Weather, option: EnumType) -> [String] {
    
    var weekDay = [String]()
    
    weather.dailyForecast.forEach {
        switch option {
        case .iPhone :
            weekDay.append(FormatDateToString(date: $0.date, format: "EEEEEE"))
        case .iPad :
            weekDay.append(FormatDateToString(date: $0.date, format: "E"))
        default:
            _ = ""
        }
    }
    
    return weekDay
}

func updateForegroundColors(index: Int, colorsForegroundStandard: [Color], foregroundColor: Color, foregroundColorIndex1: Color) -> ([Color]) {
    var colors : [Color] = colorsForegroundStandard
    
    if index > 0 {
        colors[index] = foregroundColor
    } else {
        colors[index] = foregroundColorIndex1
    }
    
    return colors
}

func updateBackgroundColors(index: Int, colorsBackgroundStandard: [Color], backGroundColor: Color, backgroundColorIndex1: Color) -> ([Color]) {
    var colors : [Color] = colorsBackgroundStandard
    
    if index > 0 {
        colors[index] = backGroundColor
    } else {
        colors[index] = backgroundColorIndex1
    }
    
    return colors
}

