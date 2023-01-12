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
    
    @EnvironmentObject var dateSettings : DateSettings

    @State private var dataArray: [Double] = Array(repeating: Double(), count: 24)

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
                        .offset(x: UIDevice.isIpad ? -20 : -20)
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
            /// Oppdaterer minMaxArray ved ending av index:
            ///
            .onChange(of: index) { index in
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
                             [Double]) = FindDataFromMenu(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .airPressure,
                                                          option1: .number12)
                dataArray = value.0
            }
            ///
            /// Finner minMaxArray ved oppstarten:
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
                             [Double]) = FindDataFromMenu(weather: weather,
                                                          date: dateSettings.dates[index],
                                                          option: .airPressure,
                                                          option1: .number12)
                dataArray = value.0
            }
        }
    }
}
