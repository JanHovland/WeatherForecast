//
//  FindHourToCGFloat.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/04/2023.
//

import Foundation

func FindHourToCGFloat(hour: String) -> CGFloat {
    var time: String = ""
    time = hour
    
    if time.count == 0 {
        return 0.00
    }
    
    if time.count == 4 {
        time = "0" + time
    }
    let h10 = Int(time[0])! * 10
    let h1 = Int(time[1])!
    let h = CGFloat(h10 + h1)
    let m10 = Int(time[3])! * 10
    let m1 = Int(time[4])!
    let f =  CGFloat((m10 + m1)) / 60.0
    let g = h + f
    return g
}


