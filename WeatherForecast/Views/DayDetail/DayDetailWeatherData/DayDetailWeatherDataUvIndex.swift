//
//  DayDetailWeatherDataUvIndex.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataUvIndex: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
        
    @EnvironmentObject var dateSettings : DateSettings
 
    @State private var dataArray: [Double] = Array(repeating: Double(), count: 24)
    
    var body: some View {
        if menuTitle == "UV-indeks" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (spacing: 4) {
                            HStack {
                                Text("\(weather.currentWeather.uvIndex.value)")
                                    .font(.title)
                            }
                            HStack (alignment: .lastTextBaseline) {
                                Text(UvIndexCurrentDescription(weather: weather))
                                    .font(.title3)
                            }
                        }
                        .offset(x: UIDevice.isIpad ? -70 : -70)
                    }
                    VStack {
                        Text(String(localized: "UTI from the World Health Organization."))
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                    .padding(.bottom, 8)
                 } else {
                    VStack {
                        HStack (spacing: 4) {
                            HStack {
                                Text(String("\(Int(round(dataArray.max()!)))"))
                                    .font(.title)
                            }
                            HStack (alignment: .lastTextBaseline) {
                                ///
                                /// Viser bekrivelsen av uvIndeks:
                                ///
                                Text(UvIndexDescription(uvIndex: Int(round(dataArray.max()!))))
                                    .font(.title3)
                            }
                        }
                        .offset(x: UIDevice.isIpad ? -70 : -70)
                    }
                    VStack {
                        Text(String(localized: "UTI from the World Health Organization."))
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                    .padding(.bottom, 8)
                }
            }
            ///
            /// Oppdaterer minMaxArray ved ending av index:
            ///
            .onChange(of: index) { index in
                ///
                /// Resetter minMaxArray:
                ///
                dataArray.removeAll()
                let value : ([Double],
                             [String],
                             [String],
                             [RainFall],
                             [WindInfo],
                             [Temperature],
                             [Double],
                             [WeatherIcon],
                             [Double],
                             [FeltTemp],
                             [Double]) = FindDataFromMenu(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .uvIndex,
                                                          option1: .number12)
                dataArray = value.0
            }
            ///
            /// Finner minMaxArray ved oppstarten:
            ///
            .task {
                ///
                /// Resetter minMaxArray vwd oppstart:
                ///
                dataArray.removeAll()
                let value : ([Double],
                             [String],
                             [String],
                             [RainFall],
                             [WindInfo],
                             [Temperature],
                             [Double],
                             [WeatherIcon],
                             [Double],
                             [FeltTemp],
                             [Double]) = FindDataFromMenu(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .uvIndex,
                                                          option1: .number12)
                dataArray = value.0
            }
        }
    }
}

