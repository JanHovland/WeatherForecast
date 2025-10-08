//
//  AirPressure.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/10/2022.
//

import SwiftUI
import WeatherKit

///
/// Lufttrykk angis i enheten pascal (Pa), men innen meteorologien nyttes
/// enheten hektopascal (hPa)
/// som gir tallverdi lik den tidligere brukte enheten millibar (mb).
///

/// https://snl.no/lufttrykk  
/// 

struct AirPressure : View {
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var showNewView = false
    @State private var dateSelected = ""
    @State private var dayDetailHide: Bool = true

    @State private var minValue : CGFloat = 890.0
    @State private var maxValue : CGFloat = 1100.0

    var body: some View {
        VStack {
            /// Viser overskriften for regn de siste 24 timene:
            ///
            HStack {
                Image(systemName: "gauge.medium")
                    .font(Font.headline.weight(.regular))
                Text("AIR PRESSURE")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            ZStack (alignment: .center) {
                Gauge(value: weather.currentWeather.pressure.value, in: minValue...maxValue) {
                    Label("", systemImage: "")
                }
                .tint(.primary)
                .opacity(0.50)
                .scaleEffect(2.5)
                .gaugeStyle(.accessoryCircular)
                
                HStack (spacing: 73) {
                    Text(String(localized: "Low"))
                    Text(String(localized: "High"))
                }
                .padding(.top, 130)
                /// Viser tendensen i lufttrykket:
                ///
                HStack (alignment: .center) {
                    if weather.currentWeather.pressureTrend == .steady {
                        Image(systemName: "equal")
                    } else if weather.currentWeather.pressureTrend == .falling {
                        Image(systemName: "arrow.down.to.line.compact")
                    } else {
                        Image(systemName: "arrow.up.to.line.compact")
                    }
                }
                .font(.system(size: 30, weight: .medium))
                .padding(.bottom, 70)
                
                /// Viser lufttrykket i hPa:
                ///
                VStack (alignment: .center) {
                    Text("\(Int(currentWeather.pressure))")
                        .font(.system(size: 40, weight: .light))
                    Text("hPa")
                }
                .padding(.top, 30)
                .padding(.leading, 0)
            }
            .padding(.top, 10)
        }
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
                      ///
                      /// Air pressure = Lufttrykk
                      ///
                      menuIcon: "gauge.medium",
                      menuTitle: String(localized: "Air pressure"))
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

