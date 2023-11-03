//
//  AirQualityViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 02/11/2023.
//

import SwiftUI
import Foundation

struct AirQualityViewModifier: ViewModifier {
    let so2Index: Int
    let index: Int

    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        let colors: [Color] = [.green, .green, .yellow, .orange, .red, .purple]
        
        content
            .foregroundColor(colors[so2Index])
    }
}
