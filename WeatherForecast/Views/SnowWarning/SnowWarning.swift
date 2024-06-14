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
                    Text("\(FormatDateToString(date: Date().setTime(hour: 0, min: 0, sec: 0)!, format: "EEEE d. MMMM yyyy", offsetSec: weatherInfo.offsetSec)).")
                }
                .font(Font.headline.weight(.regular))
                .padding(5)
                .foregroundColor(.black)
                .background(
                    RoundedRectangle(
                        cornerRadius: 7.5,
                        style: .continuous
                    )
                    .fill(Color("LightYellow"))
                    .saturation(1)
                )
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(snowWarning, id: \.self) { snow in
                            VStack {
                                if snow.value > 0.00 {
                                    Text(FormatDateToString(date: snow.date, format: "EEEE d. MMM", offsetSec: weatherInfo.offsetSec).firstUppercased)
                                    Text("\(String(format: "%.0f", snow.value)) mm " + String(localized: "snow"))
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
            var warning = SnowWarning()
            snowWarning.removeAll()
            let startDate = Date().setTime(hour: 0, min: 0, sec: 0)
            let endDate = (Calendar.current.date(byAdding: .day, value: 10, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            if dailyForecast != nil {
                dailyForecast!.forEach  {
                    if $0.date >= startDate! &&
                        $0.date <= endDate! {
                        warning.date = $0.date
                        warning.value = $0.precipitationAmountByType.snowfallAmount.amount.value
                        if warning.value > 0.00 {
                            snowWarning.append(warning)
                        }
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
