//
//  ToInteger.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 01/11/2024.
//

import Foundation

///
/// ToInteger 5.00 / 2 gir 3 til nærmeste hele tall
/// ToInteger 4.90 / 2 gir 2 til nærmeste hele tall
///

func ToInteger(_ numerator: Double, _ denominator: Double) -> Int {
    var value = 0
    
    if numerator != 0.00, denominator != 0.00 {
        value = Int(round(numerator / denominator))
    }
    
    return value
}
