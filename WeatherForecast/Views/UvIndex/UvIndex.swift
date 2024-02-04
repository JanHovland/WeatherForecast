//
//  UvIndex.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/10/2022.
//

import SwiftUI
import WeatherKit

struct UvIndex : View {
    let weather: Weather
    var body: some View {
        VStack {
            /// Viser overskriften for Uv-indeksen:
            ///
            UvIndexHeading()
            /// Viser Uv-indeksen:
            ///
            UvIndexShowCurrentValue(weather: weather)
            /// Viser grafisk nivå på Uv-indeksen:
            ///
            UvIndexGraphicDisplay(uvIndexValue: CGFloat(weather.currentWeather.uvIndex.value))
            /// Viser Uv-indeks resten av dagen:
            ///
            UvIndexRestOfDay(weather: weather)
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

