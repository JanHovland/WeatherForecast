//
//  IconVisibilityView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/12/2022.
//

import SwiftUI

struct IconVisibilityView: View {
    
    @Binding var visabilityArray: [String]
    let spacing: Double
    let fontSize: Double
    let padding: Double
    
    var body: some View {
        HStack (spacing: spacing) {
            ForEach(Array(visabilityArray.enumerated()), id: \.element) { idx, element in
                VStack {
                    Text("\(element.description)km")
                        .font(.system(size: fontSize))
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal, padding)
                }
            }
        }
    }
}
