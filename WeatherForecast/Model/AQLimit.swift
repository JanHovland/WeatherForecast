//
//  AQLimit.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 02/11/2023.
//

import Foundation

struct AQLimit: Identifiable {
    var id = UUID()
    var designation: String = ""
    var index: Int = 0
    var range: String = ""
}

