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
            VStack {
                if averageMonthPrecification.count > 0 {
                    Text("Precification mars = \(averageMonthPrecification[2])")
                        .padding(20)
                }
                
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}

