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
    
    @State private var fromDate = GetLocalDate(date: Date())
    @State private var toDate = GetLocalDate(date: Date())
    @State private var offsetDay = 0
    @State private var offsetHour = 0
    
    @State private var width = 0
    
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
                                    ///"d MMM" ----> 14 okt.
                                    ///
                                    Text(FormatDateToString(date: hourItem.date, format: "d MMM"))
                                        .foregroundColor(.mint)
                                        .font(.footnote)
                                    ///" HH:mm" ----> 17:00
                                    ///
                                    Text(FormatDateToString(date: hourItem.date, format: "HH:mm"))
                                        .font(.footnote)
                                }
                                Image(systemName: "\(hourItem.symbolName)")
                                /// Dette brukes for å fylle symbolene:
                                ///
                                    .frame(width: 20, height: 20)
                                    .environment(\.symbolVariants, .fill)
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundStyle(.primary)
                                    .font(.title3)
                                    .padding(.top, -10)
                                
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
                                /// Viser temperaturen:
                                /// 
                                Text(Measurement<UnitTemperature>(value: round(hourItem.temperature.value), unit: .celsius).formatted())
                                    .font(.caption)
                                    .padding(.top, -10)
                            }
                            .padding(7)
                        }
                    }
                }
                
            }
        }
        .task {
            /// Oppdaterer bredden avhengig av on iPhone eller iPad:
            ///
            if UIDevice.isIpad {
                width = 790
            } else {
                width = 390
            }
            
            /// Endrer  "fromDate" 1 (en) time bakover:
            ///
            /// For å få overensstemmelse mellom datoer og weather data må
            /// hoursFromGMT() benyttes.
            ///
            offsetHour = -2
            fromDate = DateAddHour(hour: offsetHour - HoursFromUTC())
            
            /// Endrer "fromDate" 2 (to) dager fremover:
            ///
            offsetDay = 2
            toDate = DateAddDay(day: offsetDay)
            
        }
        .frame(width: CGFloat(width))
        .modifier(DayDetailBackground())
    }
}
