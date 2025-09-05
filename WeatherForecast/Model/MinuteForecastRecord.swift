//
//  MinuteForecastRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import Foundation

struct MinuteForecastRecord : Identifiable {
    var id = UUID()
    /// The start time of the minute weather.
    var date = Date()
    /// A description of the precipitation for this minute.
    var precipitation = String()
    /// The value is from `0` (no chance of precipitation) to `1` (100% chance of precipitation).
    var precipitationChance = Double()
    ///  The value's unit is kilometers per hour.
    var precipitationIntensity = Double()
}
