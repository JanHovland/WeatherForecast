//
//  SnowWarning.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/02/2024.
//

import SwiftUI

struct SnowWarningView: View {
    
    @State private var snowWarning: [SnowWarning] = []
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(snowWarning, id: \.self) { snow in
                    Text(FormatDateToString(date: snow.date, format: "EEEE", offsetSec: weatherInfo.offsetSec).firstUppercased)
                    if snow.value > 0.00 {
                        Text(String(format: "%.1f", snow.value))
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
            }
        }
        .task {
            var sw = SnowWarning()
            
            sw.date = Date()
            sw.value = 1.123
            snowWarning.append(sw)
            
            sw.date = Date().adding(days: 1)
            sw.value = 4.56
            snowWarning.append(sw)
            
        }
        .frame(maxWidth: 400, // .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
    
}

struct SnowWarning: Identifiable, Hashable {
    let id = UUID()
    var date: Date = Date()
    var value: Double = 0.00
}
