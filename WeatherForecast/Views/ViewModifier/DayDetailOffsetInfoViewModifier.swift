//
//  DayDetailOffsetInfoViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/11/2023.
//

import SwiftUI

struct DayDetailOffsetInfoViewModifier: ViewModifier {
    let option: EnumType
    
    @ViewBuilder
    func body(content: Content) -> some View {
        
        if self.option == .temperature {
            content.offset(y: UIDevice.isIpad ? -225 : -160)

        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? -320 : -260)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? -290 : -210)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? -320 : -225)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? -295 : -235)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -300 : -210)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? -300 : -190)
            
        } else if self.option == .airPressure {
            content.offset(y: UIDevice.isIpad ? -290 : -200)
        }
    }
}
