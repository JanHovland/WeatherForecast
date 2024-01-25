//
//  CountryRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/01/2024.
//

import Foundation

struct CountryRecord: Hashable, Identifiable {
    var id = UUID()
    var name: String = ""
    var code: String = ""
    var flag: String = ""
}

