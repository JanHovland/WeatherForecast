//
//  HourlyForecastRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import Foundation

struct HourlyForecastRecord : Identifiable {
    var id = UUID()
    /// The start time of the hour weather.
    var date = Date()
    /// The range of the value is from `0` to `1`
    var cloudCover = Double()
    /// An enumeration value indicating the condition at the time.
    var condition = String()
    /// The SF Symbol icon for the current weather condition.
    var symbolName = String()
    /// The temperature at which relative humidity is 100%.
    var dewPoint = Double()
    /// The amount of water vapor in the air.
    var humidity = Double()
    /// A Boolean value indicating whether there is daylight.
    var isDaylight : Bool = false
     /// Description of precipitation for this hour.
    var precipitation = Double()
    /// The value is from `0` (0% probability) to `1` (100% probability).
    var precipitationChance = Double()
    /// The amount of precipitation for the hour.
    var precipitationAmount = Double()
    /// The sea level air pressure in millibars.
    var pressure = Double()
    /// The change of air pressure. "rising" :  "arrow.up.to.line.compact " ,  "falling" :  "arrow.down.to.line.compact "  or "steady" :  " equal" .
    var pressureTrend = String()
    /// The current temperature.
    var temperature = Double()
    /// The feels-like temperature when factoring wind and humidity.
    var apparentTemperature = Double()
    /// The level of ultraviolet radiation.
    var uvIndex = Int()
    /// The distance at which terrain is visible.
    var visibility = Double()
    /// The wind speedt.
    var windSpeed = Double()
    /// The wind gust.
    var windGust = Double()
    /// The wind directiont.
    var windDirection = Double()
}
