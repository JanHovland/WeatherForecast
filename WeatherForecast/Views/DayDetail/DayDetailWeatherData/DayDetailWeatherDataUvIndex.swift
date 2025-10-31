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
        
    @Environment(DateSettings.self) private var dateSettings

    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        if menuTitle == "UV-indeks" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (alignment: .center) {
                            HStack (alignment: .center) {
                                Text("\(weather.currentWeather.uvIndex.value)")
                                    .font(.title)
                            }
                            HStack (alignment: .center) {
                                Text(UvIndexCurrentDescription(weather: weather))
                                    .font(.title3)
                            }
                        }
                    }
                    VStack {
                        Text(String(localized: "UTI from the World Health Organization."))
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                 } else {
                    VStack {
                        HStack (alignment: .center) {
                            HStack (alignment: .center) {
                                Text(String("\(Int(round(dataArray.max()!)))"))
                                    .font(.title)
                            }
                            HStack (alignment: .center) {
                                ///
                                /// Viser bekrivelsen av uvIndeks:
                                ///
                                Text(UvIndexDescription(uvIndex: Int(round(dataArray.max()!))))
                                    .font(.title3)
                            }
                        }
                    }
                    VStack {
                        Text(String(localized: "UTI from the World Health Organization."))
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                }
            }
            .padding(.leading, 10)
            ///
            /// Oppdaterer dataArray ved ending av index:
            ///
            .onChange(of: index) { oldIndex, index in
                ///
                /// Resetter dataArray:
                ///
                dataArray.removeAll()
                let value : ([Double],
                             [String],
                             [String],
                             [WindInfo],
                             [Temperature],
                             [Double],
                             [WeatherIcon],
                             [Double],
                             [FeltTemp],
                             [Double],
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataUvIndex change index",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .uvIndex,
                                                                    option1: .number12)
                dataArray = value.0
            }
            ///
            /// Finner dataArray ved oppstarten:
            ///
            .task {
                ///
                /// Resetter dataArray vwd oppstart:
                ///
                dataArray.removeAll()
                let value : ([Double],
                             [String],
                             [String],
                             [WindInfo],
                             [Temperature],
                             [Double],
                             [WeatherIcon],
                             [Double],
                             [FeltTemp],
                             [Double],
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataUvIndex .task",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .uvIndex,
                                                                    option1: .number12)
                dataArray = value.0
            }
        }
    }
}

