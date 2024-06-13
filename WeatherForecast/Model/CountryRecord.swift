//
//  CountryRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/01/2024.
//

import Foundation

struct CountryRecord: Identifiable, Hashable  {
    var id = UUID()
    var name: String = ""
    var code: String = ""
    var flag: String = ""
    var capital: String = ""
    var population: Int = 0
}

