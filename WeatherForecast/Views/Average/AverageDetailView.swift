//
//  AverageDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation

struct AverageDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
//    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("Average")
                Spacer()
            }
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 20)
                        })
                    }
                }
            }
            .offset(y: UIDevice.isIpad ? -22.5 : -22.5)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Total ** precification** for mars = ") // \(weatherInfo.averageMonthPrecification[2])")
                    padding(20)
                    Spacer()
                }
                
            } /// ScrollView
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

