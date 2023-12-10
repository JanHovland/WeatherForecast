//
//  AirQualityPollutionView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import SwiftUI

struct AirQualityPollutionView : View {
    let designation: String
    let index: Int
    let value: Double
    let range: String
    
    var body: some View {
        
        HStack {
            HStack {
                Text(designation)
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(index)")
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(Int(value))")
                Spacer()
            }
            HStack {
                Spacer()
                Text(range)
            }
        }
    }
}
