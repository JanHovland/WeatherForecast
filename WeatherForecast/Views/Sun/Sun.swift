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
    
    /// Inneholder soloåågang og solnedgang for 10 dager:
    ///
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    var body: some View {
        VStack {
            /// Viser overskriften for regn de siste 24 timene:
            ///
            VStack {
                HStack {
                    Image(systemName: "sunset.fill")
                        .font(Font.headline.weight(.regular))
                    Text("SUN SET")

                        .font(.system(size: 15, weight: .bold))
                }
            }
            .opacity(0.50)
            .padding(.leading, -60)
            .padding(.bottom, -35)
            /// Viser soloppgang:
            ///
            VStack {
                if !sunSets.isEmpty {
                    Text("\(sunSets[0])")
                } else {
                    Text("")
                }
            }
            .font(.system(size: 40, weight: .light))
            .padding(.top, 30)
            .padding(.bottom, -40)
            /// Viser soloversikt dag og natt:
            ///
            SunDayAndNight(factor: 7,
                           xMax: 170,
                           index: 0,
                           sunRises: $sunRises,
                           sunSets: $sunSets)
            /// Finner solnedgang:
            ///
            let s = String(localized: "Sun rise: ")
            if !sunSets.isEmpty {
                Text("\(s) \(sunRises[0])")
            } else {
                Text("")
            }
        }
        .padding(.leading, 10)
        .padding(.bottom, 15)
        .frame(width: 160, height: 180)
        .padding(15)
        .modifier(DayDetailBackground())
        .task {
        }
    }

}

