//
//  DayDetailWeatherDataFeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataFeelsLike: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    
    @Environment(DateSettings.self) private var dateSettings

    @State private var dataArrayFL: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var dataArrayAT: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        if menuTitle == "Føles som" {
            VStack {
                if index == 0 {
                    VStack {
                        VStack {
                            HStack (spacing: 4) {
                                HStack (alignment: .center) {
                                    Text("\(Int((weather.currentWeather.apparentTemperature.value).rounded()))º")
                                        .font(.title)
                                }
                            }
                        }
                        VStack {
                            HStack (spacing: 4) {
                                Text(String(localized: "Actual "))
                                Text("\(Int((weather.currentWeather.temperature.value).rounded()))º")
                            }
                            .font(.subheadline)
                            .opacity(0.5)
                        }
                    }
                    .padding(.bottom, 8)

                } else {
                    VStack {
                        VStack {
                            HStack (spacing: 4) {
                                Text("\(Int(dataArrayFL.max()!.rounded()))º")
                                Text("\(Int(dataArrayFL.min()!.rounded()))º")
                                    .opacity(0.5)
                            }
                            .font(.title)
                        }
                        VStack {
                            HStack (spacing: 2) {
                                Text(String(localized: "Actual: H: "))
                                Text("\(Int(dataArrayAT.max()!.rounded()))º L: ")
                                Text("\(Int(dataArrayAT.min()!.rounded()))º")
                            }
                            .font(.subheadline)
                            .opacity(0.5)
                        }
                    }
                }
            }
            ///
            /// Oppdaterer dataArrayFL ved ending av index:
            ///
            .onChange(of: index) { oldIndex, index in
                ///
                /// Finner dataArray:
                ///
                dataArrayFL.removeAll()
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
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataFeelsLike change index #1",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .feelsLike,
                                                                    option1: .number12)
                dataArrayFL = value.0
                ///
                /// Finner dataArrayAT:
                ///
                dataArrayAT.removeAll()
                let value1 : ([Double],
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
                              [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataFeelsLike change index #2",
                                                                     weather: weather,
                                                                     date: dateSettings.dates[index],
                                                                     option: .temperature,
                                                                     option1: .number12)
                dataArrayAT = value1.0
            }
            ///
            /// Finner dataArray ved oppstarten:
            ///
            .task {
                
            }
        }
    }
}
