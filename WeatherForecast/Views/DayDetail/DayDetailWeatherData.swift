//
//  DayDetailWeatherData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherData: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    @Binding var arrayDayIcons: [String]
    
    var body: some View {
        VStack {
            if menuTitle == String(localized: "Temperature") ||
                menuTitle == String(localized: "Weather conditions") {
                DayDetailWeatherDataTemperature(weather: weather,
                                                menuTitle: $menuTitle,
                                                index: $index,
                                                arrayDayIcons: $arrayDayIcons)
            } else if menuTitle == String(localized: "UV-index") {
                DayDetailWeatherDataUvIndex(weather: weather,
                                            menuTitle: $menuTitle,
                                            index: $index)
            } else if menuTitle == String(localized: "Wind") {
                DayDetailWeatherDataWind(weather: weather,
                                         menuTitle: $menuTitle,
                                         index: $index)
            } else if menuTitle == String(localized: "Rain") {
                DayDetailWeatherDataPrecifitation(weather: weather,
                                                  menuTitle: $menuTitle,
                                                  index: $index)
            } else if menuTitle == String(localized: "Feels like") {
                DayDetailWeatherDataFeelsLike(weather: weather,
                                              menuTitle: $menuTitle,
                                              index: $index)
            } else if menuTitle == String(localized: "Humidity") {
                DayDetailWeatherDataHumidity(weather: weather,
                                             menuTitle: $menuTitle,
                                             index: $index)
            } else if menuTitle == String(localized: "Visibility") {
                DayDetailWeatherDataVisibility(weather: weather,
                                               menuTitle: $menuTitle,
                                               index: $index)
            } else if menuTitle == String(localized: "Air pressure") {
                DayDetailWeatherDataAirPressure(weather: weather,
                                                menuTitle: $menuTitle,
                                                index: $index)
            }
        }
    }
}
