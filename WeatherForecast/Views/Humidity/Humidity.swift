//
//  Humidity.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/10/2022.
//

import SwiftUI
import WeatherKit

struct Humidity : View {
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var showNewView = false
    @State private var dateSelected = ""
    @State private var dayDetailHide: Bool = true


    var body: some View {
        VStack {
            /// Viser overskriften for luftfuktighet:
            ///
            HStack {
                Image(systemName: "humidity")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("HUMIDITY")
                    .font(.system(size: UIDevice.isIpad ? 14.50 : 12.25, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
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
                      /// Humidity = Luftfuktighet
                      ///
                      menuIcon: "humidity",
                      menuTitle: String(localized: "Humidity"))
        }
        .frame(maxWidth: .infinity,
               maxHeight: 200)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

