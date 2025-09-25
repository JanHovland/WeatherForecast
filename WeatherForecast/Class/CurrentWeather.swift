//
//  CurrentWeather.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import SwiftUI
import Observation

@Observable final class CurrentWeather {
    /// The date of the current weather.
    var date = Date()
    /// The hour of the current weather.
    var hour = Int()
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
    /// The sea level air pressure in millibars.
    var pressure = Double()
    /// The change of air pressure. "rising" :  "arrow.up.to.line.compact " ,  "falling" :  "arrow.down.to.line.compact "  or "steady" :  " equal" .
    var pressureTrend = String()
    /// A Boolean value indicating whether there is daylight.
    var isDaylight : Bool = false
    /// The current temperature.
    var temperature = Double()
    /// The feels-like temperature when factoring wind and humidity.
    var apparentTemperature = Double()
    /// The level of ultraviolet radiation.
    var uvIndex = Int()
    /// The distance at which terrain is visible.
    var visibility = Double()
    /// The wind speed.
    var windSpeed = Double()
    /// The wind gust.
    var windGust = Double()
    /// The wind directiont.
    var windDirection = Double()
    /// https://openweathermap.org/api/air-pollution#concept
    /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
    var aqi = Int()
    /// Image som følge av aqi:
    var image = String()
    ///  Сoncentration of CO (Carbon monoxide), μg/m3
    var co = Double()
    /// Сoncentration of NO (Nitrogen monoxide), μg/m3
    var no = Double()
    /// Сoncentration of NO2 (Nitrogen dioxide), μg/m3
    var no2 = Double()
    /// Сoncentration of O3 (Ozone), μg/m
    var o3 = Double()
    /// Сoncentration of SO2 (Sulphur dioxide), μg/m3
    var so2 = Double()
    ///  Сoncentration of PM2.5 (Fine particles matter), μg/m3
    var pm2_5 = Double()
    /// Сoncentration of PM10 (Coarse particulate matter), μg/m3
    var pm10 = Double()
    /// Сoncentration of NH3 (Ammonia), μg/m3
    var nh3 = Double()
    ///  Date and time, Unix, UTC
    var dt = Int()
    /// moonEmoji
    var moonEmoji = String()
    /// moonPhase
    var moonPhase = String()
    /// moonrise
    var moonrise = String()
    /// moonset
    var moonset = String()
    /// moonIllumination
    var moonIllumination = String()
    /// isMoonUp
    var isMoonUp = Int()
    /// daysToFullMoon
    var daysToFullMoon = Int()
    /// distanceToMoon
    var distanceToMoon = Int()
    /// isSunUp
    var isSunUp = Int()
    
    ///
    /// Økning / minking av lenden på dagslys
    ///
    
    var dayLength: Int = 0
    var dayIncrease: Int = 0
    
}
