//
//  ForegroundUvIndexViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/11/2023.
//

import SwiftUI

struct ForegroundUvIndexViewModifier: ViewModifier {
    
    var value: Int
    
    @ViewBuilder

    func body(content: Content) -> some View {
        
        switch value {
        case 0...2 :
            content.foregroundColor(.green)
            
        case 3...4 :
            content.foregroundColor(.yellow)
            
        case 5...6 :
            content.foregroundColor(.red)
            
        default:
            content.foregroundColor(.purple)
        }
        
    }
    
    
    
    
}
