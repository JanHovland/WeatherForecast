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
            
        } else if menuTitle == String(localized: "UV-index") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 40 : 40)
            
        } else if menuTitle == String(localized: "Wind") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 32.5 : 20)
            
        } else if menuTitle == String(localized: "Feels like") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 30 : 10)
            
        } else if menuTitle == String(localized: "Humidity") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 22.5 : 20)
            
        } else if menuTitle == String(localized: "Visibility") {
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 40 : 37.5)
            
        } else if menuTitle == String(localized: "Air pressure") {   
            content
                .offset(y: UIDevice.isIpad ? -20 : -20)
                .padding(.bottom, UIDevice.isIpad ? 55 : 70)
        }
    }
}

