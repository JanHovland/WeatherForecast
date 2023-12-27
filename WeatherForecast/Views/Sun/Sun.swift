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
    
    @Environment(WeatherInfo.self) private var weatherInfo
    
    var body: some View {
        VStack {
            ///
            /// Viser overskriften for sol:
            ///
            VStack {
                HStack {
                    Image(systemName: "sunrise.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(Font.headline.weight(.regular))
                    Text("SUN RISE")
                        .font(.system(size: 15, weight: .bold))
                }
            }
            .opacity(0.50)
            .padding(.leading, -60)
            .padding(.bottom, -35)
            ///
            /// Viser soloppgang:
            ///
            VStack {
                if !sunRises.isEmpty {
                    Text("\(sunRises[0])")
                } else {
                    Text("")
                }
            }
            .font(.system(size: 40, weight: .light))
            .padding(.top, 30)
            .padding(.bottom, -40)
            ///
            /// Viser soloversikt dag og natt:
            ///
            SunDayAndNight(xMax: UIDevice.isIpad ? 170 : 170,
                           index: 0,
                           sunRises: $sunRises,
                           sunSets: $sunSets)
            .offset(x: UIDevice.isIpad ? -7.5 : -6.0)
            ///
            /// Finner solnedgang:
            ///
            let s = String(localized: "Sun set: ")
            if !sunSets.isEmpty {
                Text("\(s) \(sunSets[0])")
            } else {
                Text("")
            }
            
            ///
            /// Viser lengden på dagen og økning siden i går
            ///
            
            HStack {
                Image(systemName: "sunrise.fill")
                    .symbolRenderingMode(.multicolor)
                Text("\(weatherInfo.dayLength / 60)t \(weatherInfo.dayLength % 60)m")
                let increase = String(localized: "Increase")
                let decrease = String(localized: "Decrease")
                if weatherInfo.dayIncrease >= 0 {
                    Text("\(increase) \(weatherInfo.dayIncrease)m")
                } else {
                    Text("\(decrease) \(weatherInfo.dayIncrease)m")
                }
            }
            .padding(.top, 5)
            
        }
        .padding(.leading, 10)
        .padding(.bottom, 15)
        .frame(width: 160, height: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

