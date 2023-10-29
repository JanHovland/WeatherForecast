//
//  WindInfo.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/12/2022.
//

import Foundation

//struct WindInfo: Equatable {
//    var wind : Double = 0.00
//    var gust : Double = 0.00
//    var direction : Double = 0.00
//}

struct WindInfo {
    var type: String = ""
    var data: [DataWind] = []
}

struct DataWind {
    var index: Int = 0
    var amount: Double = 0.00
    var direction: Double = 0.00
}

