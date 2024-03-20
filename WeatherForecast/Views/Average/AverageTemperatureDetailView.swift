//
//  AverageTemperatureDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation

struct AverageTemperatureDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                    Text("Temperature januar")
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
    }
}
