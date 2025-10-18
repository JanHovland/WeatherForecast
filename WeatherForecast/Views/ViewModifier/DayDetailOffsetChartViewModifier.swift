//
//  DayDetailOffsetChartViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/01/2023.
//

import SwiftUI

struct DayDetailOffsetChartViewModifier: ViewModifier {
    let option: EnumType
    
    @ViewBuilder
    func body(content: Content) -> some View {
        
        if self.option == .temperature {
           content.offset(y: UIDevice.isIpad ? -140 : -170)

        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? -130 : -240)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? -120 : -150)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? -100 : -140)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? -120 : -140)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -175 : -280)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? -120 : -170)
            
        } else if self.option == .airPressure {
            content.offset(y: UIDevice.isIpad ? -140 : -200)
        }
    }
}
