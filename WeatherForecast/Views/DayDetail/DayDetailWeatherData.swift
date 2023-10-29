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
        if menuTitle == "Temperatur" {
            DayDetailWeatherDataTemperature(weather: weather,
                                            menuTitle: $menuTitle,
                                            index: $index,
                                            arrayDayIcons: $arrayDayIcons)
        } else if menuTitle == "UV-indeks" {
            DayDetailWeatherDataUvIndex(weather: weather,
                                        menuTitle: $menuTitle,
                                        index: $index)
        } else if menuTitle == "Vind" {
            DayDetailWeatherDataWind(weather: weather,
                                     menuTitle: $menuTitle,
                                     index: $index)
        } else if menuTitle == "Nedbør" {
            DayDetailWeatherDataPrecifitation(weather: weather,
                                              menuTitle: $menuTitle,
                                              index: $index)
        } else if menuTitle == "Føles som" {
            DayDetailWeatherDataFeelsLike(weather: weather,
                                          menuTitle: $menuTitle,
                                          index: $index)
        } else if menuTitle == "Luftfuktighet" {
            DayDetailWeatherDataHumidity(weather: weather,
                                         menuTitle: $menuTitle,
                                         index: $index)
        } else if menuTitle == "Sikt" {
            DayDetailWeatherDataVisibility(weather: weather,
                                           menuTitle: $menuTitle,
                                           index: $index)
        } else if menuTitle == "Lufttrykk" {
            DayDetailWeatherDataAirPressure(weather: weather,
                                            menuTitle: $menuTitle,
                                            index: $index)
        }
    }
}
