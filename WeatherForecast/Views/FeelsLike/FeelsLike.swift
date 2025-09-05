//
//  FeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/10/2022.
//

import SwiftUI
import WeatherKit

struct FeelsLike : View {
    
    @Environment(CurrentWeather.self) private var currentWeather

    var body: some View {
        VStack {
            /// Viser overskriften for føles som:
            ///
            HStack {
                Image(systemName: "thermometer.medium")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("FEELS LIKE")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            /// Viser hvordan temperaturen føles:
            ///
            Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -70)
            VStack {
                /// Beskrivelse av hvordan temperaturen føles:
                if currentWeather.temperature.rounded() == currentWeather.apparentTemperature.rounded() {
                    Text("The same as actual temperature.")
                        .lineLimit(4)
                        .padding(.top, 10)
                } else {
                    Text("The wind can make it feel colder.")
                        .lineLimit(4)
                        .padding(.top, 10)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

