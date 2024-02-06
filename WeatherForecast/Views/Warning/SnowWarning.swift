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
        VStack {
            if !snowWarning.isEmpty {
                Text("Snow for warning")
                    .font(.title2)
                    .foregroundStyle(.cyan)
                    .fontWeight(.bold)
                    .italic()
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(snowWarning, id: \.self) { snow in
                            VStack {
                                Text(FormatDateToString(date: snow.date, format: "EEEE d. MMM", offsetSec: weatherInfo.offsetSec).firstUppercased)
                                if snow.value == 0.00 {
                                    Text("0 mm")
                                        .foregroundStyle(.cyan)
                                } else {
                                    Text("\(String(format: "%.1f", snow.value)) mm")
                                        .foregroundStyle(.cyan)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .task {
            var sw = SnowWarning()
            snowWarning.removeAll()
            let startDate = Date().setTime(hour: 0, min: 0, sec: 0)
            let endDate = (Calendar.current.date(byAdding: .day, value: 10, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            if !dailyForecast!.isEmpty {
                dailyForecast!.forEach  {
                    if $0.date >= startDate! &&
                        $0.date <= endDate! {
                        sw.date = $0.date
                        sw.value = $0.snowfallAmount.value
                        snowWarning.append(sw)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity,
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
