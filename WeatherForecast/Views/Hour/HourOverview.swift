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
    @State private var indexSunRise: Int = 0
    @State private var indexSunSet: Int = 0
    
    @Environment(WeatherInfo.self) private var weatherInfo

    var body: some View {
        
        VStack (alignment: .leading) {
            HStack () {
                Spacer()
                Text("HOURLY FORECAST from one hour backwards and two days forward")
                    .font(UIDevice.isIpad ? .body : .footnote)
                Spacer()
            }
            .opacity(0.50)
            .padding(.top,10)
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
                                ///
                                /// Viser image med .fill
                                ///
                                Image(systemName: ConvertImageToFill(image: hourItem.symbolName))
                                    .modifier(ImageViewModifier(image: ConvertImageToFill(image: hourItem.symbolName)))
                                    .frame(width: 20, height: 20)
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
//                                SunRiseOrSet(option: .sunrise, date: hourItem.date, sunTime: sunRises)
//                                SunRiseOrSet(option: .sunset, date: hourItem.date, sunTime: sunSets)
                            }
                            ///
                            /// padding mellom elementene i HStack
                            ///
                            .padding(7)
                        }
                    }
                }
                ///
                /// padding på bunnen
                ///
                .padding()
            }
        }
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
        .task {
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
    }
}

