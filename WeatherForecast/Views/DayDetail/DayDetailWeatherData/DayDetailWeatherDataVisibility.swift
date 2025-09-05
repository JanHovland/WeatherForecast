//
//  DayDetailWeatherDataVisibility.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailWeatherDataVisibility: View {
    
    let weather : Weather
    @Binding var menuTitle: String
    @Binding var index: Int
    
    @Environment(DateSettings.self) private var dateSettings

    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var text: String = ""
    @State private var text1: String = ""
    @State private var text2: String = ""

    var body: some View {
        if menuTitle == "Sikt" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (spacing: 2) {
                            HStack (alignment: .center) {
                                Text("\(Int(weather.currentWeather.visibility.value / 1000.0.rounded()))")
                                    .font(.title)
                                    .offset(x: UIDevice.isIpad ? 0 : 0)
                            }
                            HStack (alignment: .lastTextBaseline) {
                                Text("km")
                                    .font(.title3)
                                    .padding(.top, 5)
                                    .opacity(0.5)
                            }
                        }
                    }
                    VStack {
                       Text("\(DescribeVisibity(visibility: dataArray.max()!))")
                    }
                } else {
                    VStack {
                        HStack (spacing: 2) {
                            Text("\(Int(dataArray.min()!.rounded()))")
                            Text(String(localized: " to "))
                            Text("\(Int(dataArray.max()!.rounded())) km")
                        }
                        .font(.title)
                    }
                    VStack {
                        let t = DescribeVisibity(visibility: dataArray.min()!)
                        let t1 = DescribeVisibity(visibility: dataArray.max()!)
                        if t == t1 {
                            Text(t)
                                .offset(x: UIDevice.isIpad ? -45 : -40)
                        } else {
                            Text(t + String(localized: " to ")  + t1.firstLowercased)
                        }
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
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataVisibility change index",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .visibility,
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
                             [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataVisibility .task",
                                                                    weather: weather,
                                                                    date: dateSettings.dates[index],
                                                                    option: .visibility,
                                                                    option1: .number12)
                dataArray = value.0
            }
        }
    }
}

private func DescribeVisibity(visibility: Double) -> String {
    
    var text: String = ""
    
    /// https://www.met.no/vaer-og-klima/begreper-i-vaervarsling
    
    switch visibility {
        
    case 10.00...1000000.00 :
        text = String(localized: "Good visibility")
     
    case 4.00..<10.00 :
        text = String(localized: "Moderat sikt")

    case 1.00..<4.00 :
        text = String(localized: "Poor visibility")

    default:
        text = String(localized: "Misty")
    }
    
    return text
    
    
}
