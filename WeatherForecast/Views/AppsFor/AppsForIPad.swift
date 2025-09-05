//
//  AppsForIPad.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI
import WeatherKit

struct AppsForIPad: View {
    
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
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
                ///
                /// Viser månen:
                ///
                MoonView()
            }
            HStack (spacing: 8) {
                ///
                /// Viser vindretning og hastighet:
                ///
                WindView(weather: weather)
                ///
                /// Viser føles som:
                ///
                FeelsLike()
                ///
                /// Viser luftfuktighet:
                ///
                Humidity()
                ///
                /// Viser sikten:
                ///
                Visibility(weather: weather)
            }
            HStack (spacing: 8) {
                ///
                /// Viser Uv indeksen:
                ///
                UvIndex(weather: weather)
                ///
                /// Viser regn de forrige 24 timene:
                ///
                Precipitation24h(weather: weather)
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
