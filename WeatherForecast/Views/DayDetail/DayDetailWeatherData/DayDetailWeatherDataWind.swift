//
//  DayDetailWeatherDataWind.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataWind: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
   
    @EnvironmentObject var dateSettings : DateSettings
 
    @State private var dataWindArray: [Double] = Array(repeating: Double(), count: 24)
    @State private var dataGustArray: [Double] = Array(repeating: Double(), count: 24)

    var body: some View {
        if menuTitle == "Vind" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (spacing: 4) {
                            HStack (alignment: .center) {
                                Text("\(Int((weather.currentWeather.wind.speed.value * 1000 / 3600).rounded()))")
                                    .font(.title)
                            }
                            HStack (alignment: .lastTextBaseline) {
                                Text("m/s")
                                    .font(.title3)
                            }
                            Text("\(WindDirection(degree: weather.currentWeather.wind.direction.value, option: .shortDirection))")
                                .font(.title)
                                .opacity(0.5)
                        }
                    }
                    VStack {
                        HStack (spacing: 4) {
                            Text(String(localized: "Gust: "))
                            Text("\(Int((weather.currentWeather.wind.gust!.value * 1000 / 3600).rounded())) m/s")
                        }
                        .font(.subheadline)
                        .opacity(0.5)
                    }
                    .padding(.bottom, 8)
                } else {
                    VStack {
                        HStack (spacing: 2) {
                            let min = dataWindArray.min()!
                            let max = dataWindArray.max()!
                            Text("\(Int(min)) - \(Int(max)) m/s")
                                .font(.title)
                        }
                    }
                    .offset(x: UIDevice.isIpad ? -15 : -15)
                    VStack {
                        HStack (spacing: 2) {
                            Text(String(localized: "Gust up to "))
                            let max = dataGustArray.max()
                            Text("\(Int(max ?? 0.00)) m/s")
                        }
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
                /// Finner dataWindArray og dataGustArray ut fra index:
                ///
                dataWindArray.removeAll()
                dataGustArray.removeAll()
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
                                                          option: .wind,
                                                          option1: .number12)
                dataWindArray = value.0
                dataGustArray = value.6
            }
            ///
            /// Finner dataWindArray og dataGustArray ved oppstart:
            ///
            .task {
                ///
                /// Resetter dataArray:
                ///
                dataWindArray.removeAll()
                dataGustArray.removeAll()
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
                                                          option: .wind,
                                                          option1: .number12)
                dataWindArray = value.0
                dataGustArray = value.6
            }
        }
    }
}
