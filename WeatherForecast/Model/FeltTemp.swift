//
//  FeltTemp.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 03/01/2023.
//

import Foundation

struct FeltTemp {
    var type: String = ""
    var data: [FeltTempData] = []
}

struct FeltTempData {
    var index: Int = 0
    var temp : Double = 0.00
    var gust: Double = 0.00
    var wind: Double = 0.00
    var condition: String = ""
}

