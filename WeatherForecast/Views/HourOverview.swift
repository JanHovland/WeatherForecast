//
//  HourOverview.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 11/10/2022.
//

import SwiftUI
import WeatherKit

struct HourOverview: View {
    let weather : Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]

    @State private var fromDate: Date = Date()
    @State private var toDate: Date = Date()
    @State private var width: Double = 0.00
    @State private var indexSunRise: Int = 0
    @State private var indexSunSet: Int = 0
    
    @Environment(WeatherInfo.self) private var weatherInfo

    var body: some View {
        
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                if UIDevice.isIpad {
                    Text("HOURLY FORECAST from one hour backwards and two days forward")
                        .font(.body)
                } else {
                    Text("HOURLY FORECAST from one hour backwards and two days forward")
                        .font(.footnote)
                }
            }
            .opacity(0.50)
            .padding(.leading,6)
            .padding(.top,10)
            .padding(.bottom, -5)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(weather.hourlyForecast, id: \.date) { hourItem in
                        if hourItem.date >= fromDate &&
                            hourItem.date < toDate {
                            VStack (spacing: 10) {
                                VStack (spacing: 0) {
                                    ///
                                    ///  "d MMM" ----> 14 okt.
                                    ///
                                    Text(FormatDateToString(date: hourItem.date, format: "d MMM", offsetSec: weatherInfo.offsetSec))
                                        .foregroundColor(.mint)
                                        .font(.footnote)
                                    ///
                                    ///" HH:mm" ----> 17:00
                                    ///
                                    Text(FormatDateToString(date: hourItem.date, format: "HH:mm", offsetSec: weatherInfo.offsetSec))
                                        .font(.footnote)
                                }
                                Image(systemName: "\(hourItem.symbolName)")
                                ///
                                /// Dette brukes for å fylle symbolene:
                                ///
                                    .frame(width: 20, height: 20)
                                    .environment(\.symbolVariants, .fill)
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundStyle(.primary)
                                    .font(.title3)
                                    .padding(.top, -10)
                                ///
                                /// Viser precipitationChance:
                                ///
                                if hourItem.precipitationChance > 0.00 {
                                    Text("\(Int(hourItem.precipitationChance*100)) %")
                                        .font(.caption)
                                        .foregroundColor(.mint)
                                        .padding(.top, -5)
                                } else {
                                    Text("")
                                        .font(.caption)
                                        .foregroundColor(.mint)
                                        .padding(.top, -5)
                                }
                                ///
                                /// Viser mengde nedbør:
                                ///
                                if hourItem.precipitationAmount.value > 0.00 {
                                    Text(String(format: "%.2f", ceil(hourItem.precipitationAmount.value * 1000) / 1000.0))
                                        .foregroundColor(.mint)
                                        .font(.caption)
                                        .padding(.top, -10)
                                } else {
                                    Text("")
                                        .foregroundColor(.mint)
                                        .font(.caption)
                                        .padding(.top, -10)
                                    
                                }
                                ///
                                /// Viser temperaturen:
                                ///
                                Text("\(String(format: "%.2f", hourItem.temperature.value))º")
                                    .font(.caption)
                                    .padding(.top, -10)
                            }
                            VStack {
                                SunRiseOrSet(option: .sunrise, date: hourItem.date, sunTime: sunRises)
                                SunRiseOrSet(option: .sunset, date: hourItem.date, sunTime: sunSets)
                            }
                            .padding(7)
                        }
                    }
                }
            }
        }
        .task {
            ///
            /// Oppdaterer bredden avhengig av on iPhone eller iPad:
            ///
            if UIDevice.isIpad {
                width = 790
            } else {
                width = 390
            }
            ///
            ///  Legger inn en factor på en time tidligere:
            ///
            let factor = -1
            fromDate = Calendar.current.date(byAdding: .hour, value: factor, to: Date())!
            ///
            /// Endrer "todate" 2 (to) dager fremover:
            ///
            toDate = Calendar.current.date(byAdding: .day, value: 2, to: fromDate)!
        }
        .frame(width: CGFloat(width))
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
     
}
