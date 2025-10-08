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
                      ///
                      /// UV-index = UV-indeks
                      ///
                      menuIcon: "sun.max",
                      menuTitle: String(localized: "UV-index"))
        }        .frame(maxWidth: .infinity,
                        maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

