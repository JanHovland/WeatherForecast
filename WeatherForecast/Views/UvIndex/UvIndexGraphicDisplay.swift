//
//  UvIndexGraphicDisplay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/11/2022.
//

import SwiftUI

struct UvIndexGraphicDisplay: View {
    
    var uvIndexValue : CGFloat
    
    @State private var minValue : CGFloat = 0.0
    @State private var maxValue : CGFloat = 15.0
    @State private var gradient = Gradient(colors: [.green, .yellow, .orange, .red, .purple])
    
    var body: some View {
        ZStack {
            Gauge(value: uvIndexValue, in: minValue...maxValue) {
                Label("", systemImage: "")
            }
            .tint(gradient)
        }
        .frame(maxWidth: .infinity,
               maxHeight: 2)
        .gaugeStyle(.accessoryLinear)
        .padding(.top, -5)
    }
}

