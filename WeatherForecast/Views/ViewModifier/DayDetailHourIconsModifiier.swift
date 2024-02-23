//
//  DayDetailHourIconsModifiier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/02/2024.
//

import SwiftUI

struct DayDetailHourIconsModifier: ViewModifier {
    @Binding var menuTitle: String
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if menuTitle == String(localized: "Temperature") ||
            menuTitle == String(localized: "Weather conditions") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 60 : 40)
        } else {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 60 : 40)  
        }
    }
}

