//
//  AirQualityView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct AirQualityView: View {
    @Environment(CurrentWeather.self) private var currentWeather

    var body: some View {
        VStack {
            ///
            /// Viser overskriften for fluftkvaliteten:
            ///
            /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
            HStack {
                if currentWeather.aqi == 1 ||
                   currentWeather.aqi == 2 {
                    Image(systemName: "aqi.low")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                } else if currentWeather.aqi == 3 {
                    Image(systemName: "aqi.medium")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))

                } else if currentWeather.aqi == 4 ||
                          currentWeather.aqi == 5 {
                    Image(systemName: "aqi.high")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                }

                Text("AIR QUALITY")
                    .font(.system(size: 15, weight: .bold))
            }
            .opacity(0.50)
            .padding(.leading, UIDevice.isIpad ? -180 : 0)
            ///
            /// Viser status for luftkvaliteten:
            ///
            /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
            if currentWeather.aqi == 1 {
                Text("Good")
                    .foregroundColor(.indigo)
            } else if currentWeather.aqi == 2 {
                Text("Fair")
                    .foregroundColor(.green)
            } else if currentWeather.aqi == 3 {
                Text("Moderate")
                    .foregroundColor(.indigo)
            } else if currentWeather.aqi == 4 {
                Text("Poor")
                    .foregroundColor(.red)
            } else if currentWeather.aqi == 5 {
                Text("Very poor")
                    .foregroundColor(.red)
            }
            
            
            
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


