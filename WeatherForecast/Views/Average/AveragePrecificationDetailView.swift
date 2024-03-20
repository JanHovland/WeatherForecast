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
            ScrollView(showsIndicators: false) {
                VStack {
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
    }
}
