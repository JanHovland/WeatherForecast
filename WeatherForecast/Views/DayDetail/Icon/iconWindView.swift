//
//  iconWindView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/12/2022.
//

import SwiftUI

struct iconWindView: View {
    
    @Binding var windArray: [String]
    let spacing: Double
    let fontSize: Double
    let padding: Double
    
    var body: some View {
        HStack (spacing: spacing) {
            ForEach(Array(windArray.enumerated()), id: \.element) { idx, element in
                VStack {
                    if let degrees = Double(element) {
                        ///
                        /// Siden det ikke finnes et symbol som heter "location.siuth.fill" roteres "location.north.fill" 180º ekstra:
                        ///
                        Image(systemName: "location.north.fill")
                            .rotationEffect(Angle(degrees: degrees + 180), anchor: .center)
                            .font(.system(size: fontSize))
                            .symbolRenderingMode(.multicolor)
                            .padding(.horizontal, padding)
                    }
                }
            }
        }
    }
}
