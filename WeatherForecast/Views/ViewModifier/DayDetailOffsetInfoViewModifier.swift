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

        } else if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? -365: -270)
            
        } else if self.option == .precipitation{
            content.offset(y: UIDevice.isIpad ? -340 : -250)
            
        } else {
            content.offset(y: UIDevice.isIpad ? -345 : -245)
        }
    }
}
