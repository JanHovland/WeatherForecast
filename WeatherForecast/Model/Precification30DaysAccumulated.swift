//
//  Precification30DaysAccumulated.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 17/04/2024.
//

import Foundation


struct Precipitation30DaysAccumulated : Identifiable {
    var id = UUID()
    var precipitation: Double = 0.00
    var type: String = ""
    var index: Int = 0
    var date: String = ""
}
