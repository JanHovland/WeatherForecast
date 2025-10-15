//
//  Sun.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/10/2022.
//

import SwiftUI
import WeatherKit

struct Sun : View {
   
    let weather: Weather
    ///
    /// Inneholder soloåågang og solnedgang for 10 dager:
    ///
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            ///
            /// Viser overskriften for sol:
            ///
            HStack {
                Image(systemName: "sunrise.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("SUN RISE")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            ///
            /// Viser soloppgang:
            ///
            ZStack {
                HStack {
                    Spacer()
                    if !sunRises.isEmpty {
                        Text("\(sunRises[0])")
                    } else {
                        Text("")
                    }
                    Spacer()
                }
                .font(.system(size: 40, weight: .light))
                ///
                /// Viser soloversikt dag og natt:
                ///
                SunDayAndNight(xMax: 100,
                               index: 0,
                               sunRises: $sunRises,
                               sunSets: $sunSets)
                .offset(y: 30)
                ///
                /// Finner solnedgang:
                ///
                HStack {
                    Spacer()
                    let s = String(localized: "Sun set: ")
                    if !sunSets.isEmpty {
                        Text("\(s) \(sunSets[0])")
                    } else {
                        Text("")
                    }
                    Spacer()
                }
                .offset(y:85)
                ///
                /// Viser lengden på dagen og økning siden i går
                ///
                HStack (spacing: 0) {
                    Spacer()
                    Image(systemName: "sunrise.fill")
                        .symbolRenderingMode(.multicolor)
                    Text("\(currentWeather.dayLength / 60)t \(currentWeather.dayLength % 60)m")
                    if currentWeather.dayIncrease >= 0 {
                        Text("  + \(currentWeather.dayIncrease)m")
                    } else {
                        Text("  \(currentWeather.dayIncrease)m")
                    }
                    Spacer()
                }
                .font(UIDevice.isIpad ? .body : .subheadline)
                .offset(y: 115)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

