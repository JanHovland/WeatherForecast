//
//  DayDetailBackground.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 09/01/2023.
//

import SwiftUI

struct DayDetailBackground: ViewModifier {
    
    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        content
            .background(
                RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous
                )
                .fill(Color("Background#01").opacity(0.65))
            )
    }
}
