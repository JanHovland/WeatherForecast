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
            content.offset(y: UIDevice.isIpad ? -130 : -185)
            
        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? -150 : -270)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? -140 : -185)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? -130 : -185)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? -140 : -185)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -200 : -290)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? -130 : -180)
            
        } else {
            content.offset(y: UIDevice.isIpad ? -345 : -245)
        }
    }
}
