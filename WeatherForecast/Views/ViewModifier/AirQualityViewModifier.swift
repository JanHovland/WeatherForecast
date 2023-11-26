//
//  AirQualityViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 02/11/2023.
//

import SwiftUI
import Foundation

struct AirQualityViewModifier: ViewModifier {
    let aqIndex: Int
    let index: Int

    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        let colors: [Color] = [.green, .green, .yellow, .orange, .red, .purple]
        
        content
            .foregroundColor(colors[aqIndex])
    }
}

struct ShowItemViewModifier: ViewModifier {
    
    let heading: String
    
    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        if heading.contains(String(localized: "Rain ")) {
            content
                .foregroundColor(Color.accentColor)
        } else if heading.contains(String(localized: "Snow")) {
            content
        } else if heading.contains(String(localized: "Hail")) {
            content
                .foregroundColor(Color(.red))
        } else if heading.contains(String(localized: "Mixed")) {
            content
                .foregroundColor(Color(.purple))
        } else if heading.contains(String(localized: "Sleet")) {
            content
                .foregroundColor(Color(.yellow))
        }
    }
}
