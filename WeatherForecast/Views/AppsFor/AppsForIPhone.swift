//
//  AppsForIPhone.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI
import WeatherKit

struct AppsForIPhone: View {
    
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather

    var body: some View {
        VStack {
            ///
            /// Viser kart
            ///
            MapDetailView()
            
            HStack (spacing: 8) {
                ///
                /// Viser luftkvaliteten:
                ///
                AirQualityView()
            }
           HStack (spacing: 8) {
                ///
                /// Viser månen:
                ///
                MoonView()
            }
            HStack (spacing: 8) {
                ///
                /// Viser vindretning og hastighet:
                ///
                WindView(weather: weather,
                         sunRises: $sunRises,
                         sunSets: $sunSets)
                    ///
                /// Viser føles som:
                ///
                FeelsLike(weather: weather,
                          sunRises: $sunRises,
                          sunSets: $sunSets)
            }
            
            HStack (spacing: 8) {
                ///
                /// Viser luftfuktighet:
                ///
                Humidity(weather: weather,
                         sunRises: $sunRises,
                         sunSets: $sunSets)
                ///
                /// Viser sikten:
                ///
                Visibility(weather: weather,
                           sunRises: $sunRises,
                           sunSets: $sunSets)
            }

            HStack (spacing: 8) {
                ///
                /// Viser Uv indeksen:
                ///
                UvIndex(weather: weather,
                        sunRises: $sunRises,
                        sunSets: $sunSets)
                ///
                /// Viser regn de forrige 24 timene:
                ///
                Precipitation24h(weather: weather)
            }
            
            HStack (spacing: 8) {
                ///
                /// Viser solen:
                ///
                Sun(weather: weather,
                    sunRises: $sunRises,
                    sunSets: $sunSets)
                ///
                /// Viser lufttrykket:
                ///
                AirPressure(weather: weather)
            }
        }
        ///
        /// Viser oversikt pr. dag:
        ///
        DayOverview(weather: weather,
                    sunRises: $sunRises,
                    sunSets: $sunSets)
        ///
        /// Viser historikken for været:
        ///
        WeatherForecastHistoryEurope()
    }
}
