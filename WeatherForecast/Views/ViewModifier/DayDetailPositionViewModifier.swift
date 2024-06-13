//
//  DayDetailPositionViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/04/2023.
//

import SwiftUI

struct DayDetailPositionViewModifier: ViewModifier {
    let option: EnumType
    let xPos: CGFloat
    
    @ViewBuilder
    func body(content: Content) -> some View {
        
        switch option {
            
        case .temperature :
            content.position(x: xPos, y: UIDevice.isIpad ? -170 : -197.5)   /// Posisjon oppe
            
        case .uvIndex :
            content.position(x: xPos, y: UIDevice.isIpad ? -185 : -212.5)   /// Posisjon oppe
            
        case .wind :
            content.position(x: xPos, y: UIDevice.isIpad ? -165 : -195)     /// Posisjon oppe
            
        case .feelsLike :
            content.position(x: xPos, y: UIDevice.isIpad ? -175 : -195)     /// Posisjon oppe
            
        case .humidity :
            content.position(x: xPos, y: UIDevice.isIpad ? -152.5: -177.5)  /// Posisjon oppe
            
        case .visibility :
            content.position(x: xPos, y: UIDevice.isIpad ? -172.5: -207.5)  /// Posisjon oppe
            
        case .airPressure :
            content.position(x: xPos, y: UIDevice.isIpad ? -165: -190)      /// Posisjon oppe
            
        case .precipitation :
            content.position(x: xPos, y: UIDevice.isIpad ? -165: -190)      /// Posisjon oppe
            
        default:
            content.position(x: xPos, y: UIDevice.isIpad ? -182.5 : -209)   /// Posisjon oppe
        }
    }
}
