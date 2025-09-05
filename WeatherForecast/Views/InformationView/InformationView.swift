//
//  InformationView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/03/2023.
//

import SwiftUI

struct InformationView: View {
    
    @State private var information =
"""
1.  If tomorrow is selected in \"DAY OVERVIEW\", today's date is displayed in DayDetail().
    Temperature (missing . after 4)
"""
    
    var body: some View {
        GeometryReader { geo  in
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading, spacing: 10) {
                    TextField("", text: $information, axis: .vertical)
                        .lineLimit(1000)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                        .padding(.horizontal, 10)
                }
            }
            .frame(width: geo.size.width)
        }
    }
}

