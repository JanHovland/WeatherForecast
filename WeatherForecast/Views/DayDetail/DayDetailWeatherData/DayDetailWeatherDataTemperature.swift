//
//  DayDetailWeatherDataTemperature.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataTemperature: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    @Binding var arrayDayIcons: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        VStack {
            if index == 0 {
                VStack {
                    HStack (alignment: .center) {
                        Spacer()
                        Text("\(Int(weather.currentWeather.temperature.value.rounded()))º")
                        ///
                        /// Denne rutinen tilpasser visning av iconene ut fra navnet på det enkelte icon:
                        ///
                        DayDetailAdaptSystemName(systemName: arrayDayIcons[index])
                        Spacer()
                    }
                    .font(.title)
                    Text(String("H: \(Int(round(dataArray.max()!))) º L: \(Int(round(dataArray.min()!))) º"))
                        .opacity(0.5)
                }
            } else {
                VStack {
                    HStack (alignment: .center) {
                        Spacer()
                        Text(String("\(Int(round(dataArray.max()!)))º"))
                        Text(String("\(Int(round(dataArray.min()!)))º"))
                            .opacity(0.5)
                        DayDetailAdaptSystemName(systemName: arrayDayIcons[index])
                        Spacer()
                    }
                    .font(.title)
                    Text("Celcius (ºC)")
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
                         [RainFall],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataTemperature change index",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .temperature,
                                                                option1: .number24)
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataTemperature .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .temperature,
                                                                option1: .number24)
            dataArray = value.0
        }
    }
}

