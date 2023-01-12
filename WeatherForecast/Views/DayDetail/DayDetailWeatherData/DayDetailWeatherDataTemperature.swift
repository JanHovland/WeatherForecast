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
    @Binding var minMaxArray: [Double] 
    @Binding var index: Int
    @Binding var arrayDayIcons: [String]
    
    var body: some View {
        if menuTitle == "Temperatur" {
            VStack {
                if index == 0 {
                    VStack {
                        HStack (alignment: .center) {
                            Text("\(Int(weather.currentWeather.temperature.value.rounded()))º")
                            ///
                            /// Denne rutinen tilpasser visning av iconene ut fra navnet på det enkelte icon:
                            ///
                            DayDetailAdaptSystemName(systemName: arrayDayIcons[index])
                        }
                        .font(.title)
                        .offset(x: UIDevice.isIpad ? 0 : 0)
                        Text(String("H: \(Int(round(minMaxArray.max()!))) º L: \(Int(round(minMaxArray.min()!))) º"))
                            .opacity(0.5)
                            .offset(x: UIDevice.isIpad ? 0 : 0)
                        
                    }
                } else {
                    VStack {
                        HStack {
                            Text(String("\(Int(round(minMaxArray.max()!)))º"))
                            Text(String("\(Int(round(minMaxArray.min()!)))º"))
                                .opacity(0.5)
                            DayDetailAdaptSystemName(systemName: arrayDayIcons[index])
                        }
                        .font(.title)
                        Text("Celcius (ºC)")
                            .opacity(0.5)
                    }
                }
            }
        }
    }
}

