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
    @State private var info: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text(String(localized: "Overview"))
                            .font(.system(size: 22, weight: .regular))
                        Spacer()
                    }
                    .padding()
 
                    Text(info)
                        .padding()

                    Text("Precification mars = \(averageMonthPrecification[2])")
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .onAppear {
            info = String(localized: "Normally it falls")
            info = info + "117 mm "
            info = info + String(localized: "precipitation from ")
            info = info + "10. februar"
            info = info + String(localized: " to ")
            info = info + "11. mars"
            info = info + " . "
            info = info + String(localized: "In the last 30 days, the total has fallen ")
            info = info + "183 mm."
        }
    }
}
