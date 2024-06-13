//
//  SunDailyIncrease.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/12/2023.
//

import Foundation

func SunDailyLength(from: String, to: String) -> Int {
    var result: Int = 0
    
    if from.count > 0, to.count > 0 {
        
        let fromFirstTwoRange = from.startIndex..<from.index(from.startIndex, offsetBy: 2)
        let hourFrom = String(from[fromFirstTwoRange])
        
        let fromLastTwoRange = from.index(from.endIndex, offsetBy: -2)..<from.endIndex
        let minFrom = String(from[fromLastTwoRange])
        
        let toFirstTwoRange = to.startIndex..<to.index(to.startIndex, offsetBy: 2)
        let hourTo = String(to[toFirstTwoRange])
        
        let toLastTwoRange = to.index(from.endIndex, offsetBy: -2)..<from.endIndex
        let minTo = String(to[toLastTwoRange])
        
        let a = Int(hourFrom)
        let b = Int(minFrom)
        let c = (a ?? 0) * 60 + (b ?? 0)
        
        let d = Int(hourTo)
        let e = Int(minTo)
        let f = (d ?? 0) * 60 + (e ?? 0)
        
        result = f - c
        
    }
    
    return result
}
