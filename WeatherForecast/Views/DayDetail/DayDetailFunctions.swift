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
        let g = dateFormatter.string(from: date)
        
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

/*
 
 let diffComponents = Calendar.current.dateComponents([.hour], from: startDate, to: endDate)
 let hours = diffComponents.hour
 
 dates = ["24", "25", "26", "27", "28", "29", "30", "31", "1", "2"]
 dateArray =
 2023-03-24 03:29:04 +0000,
 2023-03-25 03:29:04 +0000,
 2023-03-26 03:29:04 +0000,
 2023-03-27 03:29:04 +0000,
 2023-03-28 03:29:04 +0000,
 2023-03-29 03:29:04 +0000,
 2023-03-30 03:29:04 +0000,
 2023-03-31 03:29:04 +0000,
 2023-04-01 03:29:04 +0000,
 2023-04-02 03:29:04 +0000]
 
 
 dates = ["24", "25", "26", "27", "28", "29", "30", "31", "1", "2"]
 dateArray =
 2023-03-24 00:38:59 +0000,
 2023-03-25 00:38:59 +0000,
 2023-03-26 00:38:59 +0000,
 2023-03-27 00:38:59 +0000,
 2023-03-28 00:38:59 +0000,
 2023-03-29 00:38:59 +0000,
 2023-03-30 00:38:59 +0000,
 2023-03-31 00:38:59 +0000,
 2023-04-01 00:38:59 +0000,
 2023-04-02 00:38:59 +0000]
 (lldb)
 
 
 
 
 
 */


