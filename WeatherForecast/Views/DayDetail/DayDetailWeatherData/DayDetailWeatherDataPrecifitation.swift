//
//  DayDetailWeatherDataPrecifitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit
import MapKit


struct DayDetailWeatherDataPrecifitation: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var Precipitation24hBackwards: String = ""
    
    var body: some View {
        if menuTitle == "Nedbør" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (alignment: .center) {
                            Text(Precipitation24hBackwards)
                                .font(.title)
                        }
                        HStack (alignment: .lastTextBaseline) {
                            Text(String(localized: "Totally the last 24 hours."))
                                .font(.title3)
                                .opacity(0.5)
                            
                        }
                    }
                } else {
                    VStack {
                        HStack (alignment: .center) {
                            Text("\(Int(dataArray.reduce(0, +).rounded())) mm")
                                .font(.title)
                        }
                        HStack (alignment: .lastTextBaseline) {
                            Text(String(localized: "Totally this day."))
                                .font(.title3)
                                .opacity(0.5)
                            
                        }
                        .font(.title)
                    }
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
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataPrecifitation change index",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .precipitation,
                                                                    option1: .number12)
                dataArray = value.0
            }
            ///
            /// Finner dataArray ved oppstarten:
            ///
            .task {
                ///
                /// Bruker location for Varhaug:
                ///
                let location = CLLocation(latitude: weatherInfo.latitude!,
                                          longitude: weatherInfo.longitude!)
                Task.init {
                    ///
                    /// Finner hvor mye det har regnet de siste 24 timene:
                    ///
                    
                    let value: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                                 location: location,
                                                                                 option: .backward,
                                                                             offsetSec: weatherInfo.offsetSec)

                    Precipitation24hBackwards = value.1
               }
                ///
                /// Resetter dataArray:
                ///
                dataArray.removeAll()
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
                              [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataPrecifitation .task",
                                                                     weather: weather,
                                                                     date: dateSettings.dates[index],
                                                                     option: .precipitation,
                                                                     option1: .number12)
                dataArray = value1.0
            }
        }
    }
}
