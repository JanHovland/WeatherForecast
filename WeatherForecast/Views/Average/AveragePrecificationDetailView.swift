//
//  AveragePrecificationDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI
import Foundation

struct AveragePrecificationDetailView: View {
    
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
            .padding(20)
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
                    Text("Precification januar = \(averageMonthPrecification[0])")
                    Text("Precification february = \(averageMonthPrecification[1])")
                    Text("Precification mars = \(averageMonthPrecification[2])")
                    Text("Precification april = \(averageMonthPrecification[3])")
                    Text("Precification may = \(averageMonthPrecification[4])")
                    Text("Precification june = \(averageMonthPrecification[5])")
                    Text("Precification july = \(averageMonthPrecification[6])")
                    Text("Precification august = \(averageMonthPrecification[7])")
                    Text("Precification september = \(averageMonthPrecification[8])")
                    Text("Precification october = \(averageMonthPrecification[9])")
                    Text("Precification november = \(averageMonthPrecification[10])")
                    Text("Precification desember = \(averageMonthPrecification[11])")
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
