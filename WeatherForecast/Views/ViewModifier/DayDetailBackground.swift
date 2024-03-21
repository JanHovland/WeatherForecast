//
//  DayDetailBackground.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 09/01/2023.
//

import SwiftUI


///
/// https://www.swiftbysundell.com/articles/defining-dynamic-colors-in-swift/
///

// #626178 = gammel grå for "Background#01"
// #6390B8 = ny blå     for "Background#01"

struct DayDetailBackground: ViewModifier {
    let dayLight: Bool
    
    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        content
            .background(
                RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous
                )
                .fill(Color("Background#01").opacity(dayLight == true ? 0.60 : 0.35))
                ///
                /// parameter = 1 er default verdi:
                ///
                .saturation(1)
            )
    }
}

