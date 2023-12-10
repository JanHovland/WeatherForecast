//
//  Humidity.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/10/2022.
//

import SwiftUI
import WeatherKit

struct Humidity : View {
    
    @Environment(CurrentWeather.self) private var currentWeather

    var body: some View {
        VStack {
            /// Viser overskriften for luftfuktighet:
            ///
            HStack {
                Image(systemName: "humidity")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("HUMIDITY")
                    .font(.system(size: 15, weight: .bold))
            }
            .opacity(0.50)
            .padding(.leading, -10)
            /// Viser luftfuktigheten:
            ///
            let humidity = Int(currentWeather.humidity * 100.0)
            Text("\(humidity) %")
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -60)
            VStack {
                /// Beskrivelse av luftfuktigheten:
                ///
                let dewPoint = Int(currentWeather.dewPoint.rounded())
                let string1 = String(localized: "The dewPoint is now ")
                let string2 = String(localized: "º.")
                Text("\(string1) \(dewPoint) \(string2)")
                    .lineLimit(4)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .frame(width: 160, height: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

