//
//  IconAirPressureView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/12/2022.
//

import SwiftUI

struct IconAirPressureView: View {
    
    @Binding var airpressureArray: [String]
    let spacing: Double
    let fontSize: Double
    let padding: Double
    
    var body: some View {
        HStack (spacing: spacing) {
            ForEach(Array(airpressureArray.enumerated()), id: \.element) { idx, element in
                VStack {
                    Image(systemName: "\(element.description)")
                        .font(.system(size: fontSize))
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal, padding)
                }
            }
        }
    }
}
