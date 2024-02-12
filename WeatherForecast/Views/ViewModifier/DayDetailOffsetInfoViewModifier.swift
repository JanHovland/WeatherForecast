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
            content.offset(y: UIDevice.isIpad ? -60 : -40)

        } else if self.option == .uvIndex {
            content.offset(y: UIDevice.isIpad ? -60 : -120)
            
        } else if self.option == .wind {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
            
        } else if self.option == .precipitation {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
            
        } else if self.option == .feelsLike {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
            
        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
            
        } else if self.option == .visibility {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
            
        } else if self.option == .airPressure {
            content.offset(y: UIDevice.isIpad ? -60 : -40)
        }
    }
}

