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
                HStack (spacing: 0) {
                    Text("Warning for snow from ")
                    Text("\(FormatDateToString(date: snowWarning[0].date, format: "EEEE d. MMMM yyyy", offsetSec: weatherInfo.offsetSec)).")
                }
                .opacity(0.50)
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(snowWarning, id: \.self) { snow in
                            VStack {
                                if snow.value > 0.00 {
                                    Text(FormatDateToString(date: snow.date, format: "EEEE d. MMM", offsetSec: weatherInfo.offsetSec).firstUppercased)
                                    Text("\(String(format: "%.1f", snow.value)) mm")
                                        .foregroundStyle(.cyan)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            } else {
                Text("snowWarning is empty.")
                    .foregroundStyle(.cyan)
            }
        }
        .task {
            var warning = SnowWarning()
            snowWarning.removeAll()
            let startDate = Date().setTime(hour: 0, min: 0, sec: 0)
            let endDate = (Calendar.current.date(byAdding: .day, value: 10, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            if dailyForecast != nil {
                dailyForecast!.forEach  {
                    if $0.date >= startDate! &&
                        $0.date <= endDate! {
                        warning.date = $0.date
                        warning.value = $0.snowfallAmount.value
                        snowWarning.append(warning)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity,
               idealHeight: 65)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

struct SnowWarning: Identifiable, Hashable {
    let id = UUID()
    var date: Date = Date()
    var value: Double = 0.00
}
