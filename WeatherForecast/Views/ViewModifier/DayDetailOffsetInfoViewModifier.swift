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
            content.offset(y: UIDevice.isIpad ? -325 : -235)

        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? -350 : -335)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? -325 : -245)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? -350 : -255)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? -325 : -275)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -330 : -225)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? -300 : -245)
            
        } else {
            content.offset(y: UIDevice.isIpad ? -345 : -245)
        }
    }
}
