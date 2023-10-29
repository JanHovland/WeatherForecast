//
//  SunFindSunRiseSunSet.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/10/2022.
//

import SwiftUI
import WeatherKit

func SunFindSunRiseSunSet(weather: Weather, option: EnumType, offsetSec: Int) -> (String, Int) {
    
    var c : String = ""
    var hour: Int = 0
    
    let a = FormatDateToString(date: Date(), format: ("MM-dd-yyyy"), offsetSec: offsetSec)
    weather.dailyForecast.forEach {
        let b = FormatDateToString(date: $0.date, format: ("MM-dd-yyyy"), offsetSec: offsetSec)
        if a == b {
            
            switch option {
            case .sunrise :
                c = FormatDateToString(date: $0.sun.sunrise!, format: ("HH:mm"), offsetSec: offsetSec)
                hour = Int(FormatDateToString(date: $0.sun.sunrise!, format: ("HH"), offsetSec: offsetSec))!
            case .sunset :
                c = FormatDateToString(date: $0.sun.sunset!, format: ("HH:mm"), offsetSec: offsetSec)
                hour = Int(FormatDateToString(date: $0.sun.sunset!, format: ("HH"), offsetSec: offsetSec))!
            default:
                _ = ""
                _ = 0
            }
        }
    }
    return (String(c), Int(hour))
}

