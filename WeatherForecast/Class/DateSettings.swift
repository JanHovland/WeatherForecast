//
//  DateSettings.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import SwiftUI
import Observation

@Observable final class DateSettings {
    var date = ""
    var index = 0
    var dates : [Date] = Array(repeating: Date(), count: 10)
    var weekDayArray : [String] = Array(repeating: String(), count: 10)
}
