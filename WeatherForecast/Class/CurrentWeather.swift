//
//  CurrentWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import Foundation

class CurrentWeather: ObservableObject {
    /// The date of the current weather.
    @Published var date = Date()
    /// The hour of the current weather.
    @Published var hour = Int()
    /// The range of the value is from `0` to `1`
    @Published var cloudCover = Double()
    /// An enumeration value indicating the condition at the time.
    @Published var condition = String()
    /// The SF Symbol icon for the current weather condition.
    @Published var symbolName = String()
    /// The temperature at which relative humidity is 100%.
    @Published var dewPoint = Double()
    /// The amount of water vapor in the air.
    @Published var humidity = Double()
    /// The sea level air pressure in millibars.
    @Published var pressure = Double()
    /// The change of air pressure. "rising" :  "arrow.up.to.line.compact " ,  "falling" :  "arrow.down.to.line.compact "  or "steady" :  " equal" .
    @Published var pressureTrend = String()
    /// A Boolean value indicating whether there is daylight.
    @Published var isDaylight : Bool = false
    /// The current temperature.
    @Published var temperature = Double()
    /// The feels-like temperature when factoring wind and humidity.
    @Published var apparentTemperature = Double()
    /// The level of ultraviolet radiation.
    @Published var uvIndex = Int()
    /// The distance at which terrain is visible.
    @Published var visibility = Double()
    /// The wind speed.
    @Published var windSpeed = Double()
    /// The wind gust.
    @Published var windGust = Double()
    /// The wind directiont.
    @Published var windDirection = Double()
}

