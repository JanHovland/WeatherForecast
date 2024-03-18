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
            .padding(5)
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .fill(Color.blue)
            )
            .overlay (
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
            )
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                    //                        .font(.system(size: 40, weight: .light))
                    Text("Precification mars = \(averageMonthPrecification[2])")
                    Text("Precification mars = \(averageMonthPrecification[2])")
                    Text("Precification mars = \(averageMonthPrecification[2])")
                    Text("Precification mars = \(averageMonthPrecification[2])")
                    Text("Precification mars = \(averageMonthPrecification[2])")
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

