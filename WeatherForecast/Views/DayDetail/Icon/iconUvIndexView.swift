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
    
//    @State private var tempIconArray : [String] = Array(repeating: String(), count: 24)
    
    var body: some View {
        HStack (spacing: spacing) {
            ForEach(Array(uvIndexArray.enumerated()), id: \.element) { idx, element in
                VStack {
                    Text("\(element.description)")
                        .font(.system(size: fontSize))
                        .environment(\.symbolVariants, .none)
                        .symbolRenderingMode(.multicolor)
                        .padding(.horizontal, padding)
                }
            }
        }
//        .task {
//            tempIconArray.removeAll()
//            for i in 0..<weatherIconArray[uvIconType].data.count {
//                tempIconArray.append(weatherIconArray[uvIconType].data[i].icon)
//            }
//        }
    }
}
