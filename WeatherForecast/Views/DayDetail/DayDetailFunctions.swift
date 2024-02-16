//
//  DayDetailFunctions.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2022.
//

import SwiftUI
import WeatherKit

func createDateArray(format: String, offsetSec: Int) -> ([String], [Date], [String]) {
    
    var dates: [String] = [""]
    var dateArray: [Date] = [Date()]
    var weekDayArray: [String] = [String()]
    ///
    /// Tilpasser datoen til UTC:
    ///
    var date: Date = Date().adding(seconds: offsetSec) // .setTime(hour: 0, min: 0, sec: 0)!
    var previousDate: Date = Date()
    dates.removeAll()
    dateArray.removeAll()
    weekDayArray.removeAll()
    for i in 0..<10 {
        ///
        /// Legger kun til en dag når i > 0:
        ///
        if i > 0 {
            date = date.adding(days: 1)
            let diffComponents = Calendar.current.dateComponents([.hour], from: previousDate, to: date)
            let hours = diffComponents.hour
            if hours! == 23 {
                date = date.adding(hours: 1)
            } else if hours! == 25 {
                date = date.adding(hours: -1)
            }
        }
        let dateFormatter = DateFormatter()
        ///
        /// **Må bruke UTC = 0 for å finne riktig dag: (hvis en bruker en annen UTC verdi, blir det feil dag!!!)
        ///
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "d"
        let f = dateFormatter.string(from: date)
        ///
        /// format er avhengig av iPhone eller iPad:
        ///
        dateFormatter.dateFormat = format
        let g = dateFormatter.string(from: date).firstUppercased
        dates.append(f)
        dateArray.append(date)
        weekDayArray.append(g)
        previousDate = date
     }
    return (dates, dateArray, weekDayArray)
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

