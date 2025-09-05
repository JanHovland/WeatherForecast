//
//  WeatherIcon.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 25/12/2022.
//

import Foundation

struct WeatherIcon {
    var type: Int = 0
    var data: [IconData] = []
}

struct IconData {
    ///
    /// Disse er definert i WeatherForecastMain()
    ///
    /// var uvIconType: Int = 0                       var iconData: [IconData] = []                  x
    /// var windIconType: Int = 1                   var windData: [IconData] = []                 x
    /// var humidityIconType: Int = 2            var humidityData: [IconData] = []            x
    /// var visibilityIconType: Int = 3              var visibilityData: [IconData] = []            x
    /// var airpressureIconType: Int = 4        var airpressureData: [IconData] = []
    ///
    /// var weatherIconArray: [WeatherIcon] = Array(repeating: WeatherIcon(), count: sizeArray24)
    /// var weatherIconData: [IconData] = []
    ///
    var index: Int = 0
    var icon: String = ""
}
