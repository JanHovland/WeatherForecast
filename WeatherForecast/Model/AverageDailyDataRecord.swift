//
//  AverageDataDataRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/03/2024.
//

import Foundation

struct AverageDailyDataRecord: Codable {
    var time: [String]
    var precipitationSum: [Double?]
    var temperature2MMin: [Double?]
    var temperature2MMax: [Double?]
}


