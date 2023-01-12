//
//  DateSettings.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import Foundation

class DateSettings: ObservableObject {
    @Published var date = ""
    @Published var index = 0
    @Published var dates : [Date] = Array(repeating: Date(), count: 10)
}

