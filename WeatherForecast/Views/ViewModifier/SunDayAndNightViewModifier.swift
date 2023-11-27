//
//  SunDayAndNightViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2023.
//

import SwiftUI

struct SunDayAndNightViewModifier: ViewModifier {
    @Binding var menuTitle: String
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if menuTitle  == String(localized: "Weather conditions") {
            content.offset(y: UIDevice.isIpad ? -40 : -40)
        } else {
            content.offset(y: UIDevice.isIpad ? -100 : -100)
        }
    }
}

struct DayDetailHourIconsViewModifier: ViewModifier {
    @Binding var menuTitle: String
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if menuTitle  == String(localized: "Weather conditions") {
            content.offset(y: UIDevice.isIpad ? -20 : -20)
        } else {
            content.offset(y: UIDevice.isIpad ? -80 : -80)
        }
    }
}


