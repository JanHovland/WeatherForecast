//
//  TranslateDay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/12/2022.
//

import Foundation
import SwiftUI

func TranslateDay(index: Int,
                  weekdayArray: [String]) -> String {
    
    var weekDay : String = ""
    
    let day = weekdayArray[index].firstLowercased
    
    switch day  {
        
    case "man." :
        weekDay = String(localized: "monday")
        
    case "ma." :
        weekDay = String(localized: "monday")
        
    case "tir." :
        weekDay = String(localized: "tuesday")
        
    case "ti." :
        weekDay = String(localized: "tuesday")
        
    case "ons." :
        weekDay = String(localized: "wednesday")
        
    case "on." :
        weekDay = String(localized: "wednesday")
        
    case "tor." :
        weekDay = String(localized: "thursday")
        
    case "to." :
        weekDay = String(localized: "thursday")
        
    case "fre." :
        weekDay = String(localized: "friday")
        
    case "fr." :
        weekDay = String(localized: "friday")
        
    case "lør." :
        weekDay = String(localized: "saturday")
        
    case "lø." :
        weekDay = String(localized: "saturday")
        
    case "søn." :
        weekDay = String(localized: "sunday")
        
    case "sø." :
        weekDay = String(localized: "sunday")
        
    default:
        weekDay = "Unknown"
    }
    
    return weekDay
}
