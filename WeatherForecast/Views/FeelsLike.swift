//
//  FeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/10/2022.
//

import SwiftUI
import WeatherKit

struct FeelsLike : View {
    
    @EnvironmentObject var currentWeather: CurrentWeather
    
    var body: some View {
        VStack {
            /// Viser overskriften for føles som:
            ///
            HStack {
                Image(systemName: "thermometer.medium")
                    .renderingMode(.original)
                    .font(Font.headline.weight(.regular))
                Text("FEELS LIKE")
                    .font(.system(size: 15, weight: .bold))
            }
            .opacity(0.50)
            .padding(.leading, -40)
            /// Viser hvordan temperaturen føles:
            ///
            let apparentTemperature = Measurement<UnitTemperature>(value: round(currentWeather.apparentTemperature),
                unit: .celsius).formatted()
            Text(apparentTemperature)
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -70)
            VStack {
                /// Beskrivelse av hvordan temperaturen føles:
                ///
                if round(currentWeather.temperature) == round(currentWeather.apparentTemperature) {
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
        .frame(width: 160, height: 180)
        .padding(15)
        .modifier(DayDetailBackground())
    }
}

