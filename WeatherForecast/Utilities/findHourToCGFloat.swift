//
//  findHourToCGFloat.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/11/2022.
//

import Foundation

func FindHourToCGFloat(hour: String) -> CGFloat {
    let h10 = Int(hour[0])! * 10
    let h1 = Int(hour[1])!
    let h = CGFloat(h10 + h1)
    let m10 = Int(hour[3])! * 10
    let m1 = Int(hour[4])!
    let f =  CGFloat((m10 + m1)) / 60.0
    let g = h + f
    return g
}
