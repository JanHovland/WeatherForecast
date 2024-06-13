//
//  TemperaturMinMax.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/04/2024.
//

import Foundation

struct TemperaturMinMax: Identifiable {
    var id = UUID()
    var min: Double = 0.00
    var max: Double = 0.00
    var temp: Double = 0.00
    var type: String = ""
    var hour: Int = 0
}

