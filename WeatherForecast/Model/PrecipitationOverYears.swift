//
//  PrecipitationOverYears.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 03/05/2024.
//

import Foundation

struct PrecipitationOverYears : Identifiable {
    var id = UUID()
    var precipitation: Double = 0.00
    var type: String = ""
    var index: Int = 0
    var date: String = ""
}

