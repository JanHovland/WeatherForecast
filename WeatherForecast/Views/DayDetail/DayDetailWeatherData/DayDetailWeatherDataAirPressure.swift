//
//  DayDetailWeatherDataAirPressure.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataAirPressure: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    
    @Environment(DateSettings.self) private var dateSettings


    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)

    var body: some View {
        if menuTitle == "Lufttrykk" {
            VStack {
                if index == 0 {
                    VStack {
                        VStack {
                            HStack (alignment: .center) {
                                Text("\(Int((weather.currentWeather.pressure.value).rounded()))")
                                    .font(.title)
                                Text("hPa")
                                    .font(.title3)
                                    .padding(.leading, -5)
                                    .padding(.top, 5)
                            }
                        }
                        VStack {
                            Text("\(weather.currentWeather.pressureTrend.description)")
                        }
                        .font(.subheadline)
                        .opacity(0.5)
                    }
                    .padding(.bottom, 8)
                } else {
                    VStack {
                        HStack (alignment: .center) {
                            Text( "\(Int(FindAverageArray(array: dataArray).rounded()))")
                                .font(.title)
                            Text("hPa")
                                .font(.title3)
                                .padding(.leading, -5)
                                .padding(.top, 5)
                        }
                    }
                    VStack {
                        Text(String(localized: "Average"))
                    }
                    .font(.subheadline)
                    .opacity(0.5)
                }
            }
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
                             [RainFall],
                             [WindInfo],
                             [Temperature],
                             [Double],
                             [WeatherIcon],
                             [Double],
                             [FeltTemp],
                             [Double],
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataAirPressure change index",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .airPressure,
                                                                    option1: .number12)
                dataArray = value.0
            }
            ///
            /// Finner dataArray ved oppstarten:
            ///
            .task {
                ///
                /// Resetter dataArray:
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
                             [Double],
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataAirPressure .task",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .airPressure,
                                                                    option1: .number12)
                dataArray = value.0
            }
        }
    }
}
