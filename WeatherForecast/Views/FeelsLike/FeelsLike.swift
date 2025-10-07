//
//  FeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/10/2022.
//

import SwiftUI
import WeatherKit

struct FeelsLike : View {
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var showNewView = false
    @State private var dateSelected = ""
    @State private var dayDetailHide: Bool = true

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
        ///
        /// .contentShape() må ligge foran .onTapGesture
        ///
        .contentShape(Rectangle())
        .onTapGesture {
            ///
            /// Må finne aktuelt valg:
            ///
            dateSelected = FormatDateToString(date: Date(), format: "d", offsetSec: weatherInfo.offsetSec)
            showNewView.toggle()
        }
        .fullScreenCover(isPresented: $showNewView) {
            DayDetail(weather: weather,
                      dateSelected: $dateSelected,
                      dayDetailHide: $dayDetailHide,
                      sunRises: $sunRises,
                      sunSets: $sunSets,
                      dateSettings: dateSettings,
                      /// Feels like = Føles som
                      ///
                      menuIcon: "thermometer.medium",
                      menuTitle: String(localized: "Feels like"))
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

