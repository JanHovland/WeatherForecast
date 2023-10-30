//
//  MoonView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct MoonView: View {
        @Environment(CurrentWeather.self) private var currentWeather

        var body: some View {
            VStack {
                ///
                /// Viser overskriften for fluftkvaliteten:
                ///
                HStack {
                    Image(systemName: "thermometer.medium")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                    Text("Moon")
                        .font(.system(size: 15, weight: .bold))
                }
                .opacity(0.50)
                .padding(.leading, -40)
                /// Viser hvordan temperaturen føles:
                ///
    //            Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
    //                .font(.system(size: 40, weight: .light))
    //                .padding(.top, 10)
    //                .padding(.leading, -70)
    //            VStack {
    //                /// Beskrivelse av hvordan temperaturen føles:
    //                if currentWeather.temperature.rounded() == currentWeather.apparentTemperature.rounded() {
    //                    Text("The same as actual temperature.")
    //                        .lineLimit(4)
    //                        .padding(.top, 10)
    //                } else {
    //                    Text("The wind can make it feel colder.")
    //                        .lineLimit(4)
    //                        .padding(.top, 10)
    //                }
    //            }
                Spacer()
            }
            .frame(width: 358, height: 175)
            .padding(15)
            .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        }
    }
