//
//  FindTimeFromAmPm.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/11/2023.
//

import Foundation

func FindTimeFromAmPm(time: String) -> String {
    /// https://www.cuemath.com/measurement/am-pm/+
    
    var hour: Int = 0
    var minute: Int = 0
    var newTime: String = ""
    var stringAmPm: String = ""
    var newHour: String = ""
    var newMinute: String = ""
    var timeOut: String = ""
    ///
    /// Det hender det ikke er noen måneoppgang
    ///
    if time == "No moonrise" {
        return String(localized: "No moonrise")
    }
    if time.count > 0 {
        ///
        /// legger til "0" :
        ///
        if time.count == 7 {
            newTime = "0" + time
        } else {
            newTime = time
        }
        /// PM eller AM
        let start = newTime.index(newTime.startIndex, offsetBy: 6)
        let end = newTime.index(newTime.startIndex, offsetBy: 7)
        let range = start...end
        stringAmPm = String(newTime[range])
        ///
        /// Finner hour
        ///
        let start1 = newTime.index(newTime.startIndex, offsetBy: 0)
        let end1 = newTime.index(newTime.startIndex, offsetBy: 1)
        let range1 = start1...end1
        ///
        /// Det hender at det ikke kommer noen måneoppgang/månenedgang
        ///
        if Int(String(newTime[range1])) != nil {
            hour = Int(String(newTime[range1]))!
        } else {
            hour = -1
        }
        ///
        /// Finner minute
        ///
        let start2 = newTime.index(newTime.startIndex, offsetBy: 3)
        let end2 = newTime.index(newTime.startIndex, offsetBy: 4)
        let range2 = start2...end2
        ///
        /// Det hender at det ikke kommer noen måneoppgang/månenedgang
        ///
        if Int(String(newTime[range2])) != nil {
            minute = Int(String(newTime[range2]))!
        } else {
            minute = -1
        }
        ///
        /// Oppdaterer avhengig av "AM" eller "PM"
        ///
        if stringAmPm == "PM" {
            if hour < 12 {
                hour = hour + 12
            }
        }
        if stringAmPm == "AM" {
            if hour >= 12 {
                hour = hour - 12
            }
        }
        if hour < 10 {
            newHour = "0\(hour)"
        } else {
            newHour = "\(hour)"
        }
        if minute < 10 {
            newMinute = "0\(minute)"
        } else {
            newMinute = "\(minute)"
        }
        timeOut = newHour + ":" + newMinute
    }
    if hour == -1, minute == -1 {
       timeOut = "  -  "
    } 
    return timeOut
 }
