//
//  iconUvIndexView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/12/2022.
//

import SwiftUI

struct iconUvIndexView: View {
    
    @Binding var uvIndexArray: [String]
    let spacing: Double
    let fontSize: Double
    let padding: Double
    
    var body: some View {
        HStack (spacing: spacing) {
            ForEach(Array(uvIndexArray.enumerated()), id: \.element) { idx, element in
                VStack {
                    Text("\(element.description)")
                        .font(.system(size: fontSize))
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal, padding)
                }
            }
        }
    }
}
