//
//  DayDetailChartOffsetViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/01/2023.
//

import SwiftUI

struct DayDetailChartOffsetViewModifier: ViewModifier {
    let option: EnumType

    @ViewBuilder
    func body(content: Content) -> some View {
        if self.option == .temperature {
            content.offset(y: UIDevice.isIpad ? 30 : 80)
            
        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? 20 : 70)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? 30 : 70)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? 10 : 60)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? 30 : 40)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? 90 : 190)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? 30 : 70)
            
        } else if self.option == .airPressure {
            content.offset(y: UIDevice.isIpad ? 50 : 100)
            
        } else if self.option == .probability {
            content.offset(y: UIDevice.isIpad ? -30: -30)
        }
    }
}
