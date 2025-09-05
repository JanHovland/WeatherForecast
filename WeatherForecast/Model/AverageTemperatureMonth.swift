//
//  AverageTemperatureMonth.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/04/2024.
//

import SwiftUI

struct AverageTemperatureMonth: Identifiable {
    var id = UUID()
    var month: String = ""
    var min: Int = 0
    var max: Int = 0
    var value: String = ""
}

struct AverageNormalPrecipitationMonth: Identifiable {
    var id = UUID()
    var month: String = ""
    var min: Int = 0
    var max: Int = 0
    var value: String = ""
}

