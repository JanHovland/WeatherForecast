//
//  DateString.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/02/2023.
//

import Foundation

///
/// Date()                       = UTC + 0        2023-02-05 19:00
///
/// Lokal tid på Varhaug = UTC + 1       2023-02-05 20:00
///

func DateString(_ date: Date) -> String {
    
    var seconds: Int {
      Calendar.current.component(.second, from: date)
    }
    
    var minutes: Int {
      Calendar.current.component(.minute, from: date)
    }
    
    var hours: Int {
      Calendar.current.component(.hour, from: date)
    }
    
    var timeString: String {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    return timeString
        
}
