//
//  Temperatur.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/12/2022.
//

import Foundation

struct Temperature {
    var type: String = ""
    var data: [TempData] = []
}

struct TempData {
    var index: Int = 0
    var temp : Double = 0.00
    var gust: Double = 0.00
    var wind: Double = 0.00
    var condition: String = ""
}

