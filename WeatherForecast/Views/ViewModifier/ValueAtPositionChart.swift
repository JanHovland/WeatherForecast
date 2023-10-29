//
//  ValueAtPositionChart.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/10/2023.
//

import SwiftUI

struct ValueAtPositionChart: ViewModifier {
    
    var selectedIndex: Int
    
    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        if selectedIndex == 0 {
            content
                .offset(x: UIDevice.isIpad ? 25 : 25,
                        y: UIDevice.isIpad ? 0 : 0)
        } else if selectedIndex == 1 {
            content
                .offset(x: UIDevice.isIpad ? 10 : 10,
                        y: UIDevice.isIpad ? 0 : 0)
        } else if selectedIndex == 22 {
            content
                .offset(x: UIDevice.isIpad ? -10: -10,
                        y: UIDevice.isIpad ? 0 : 0)
        } else if selectedIndex == 23 {
            content
                .offset(x: UIDevice.isIpad ? -25 : -25,
                        y: UIDevice.isIpad ? 0 : 0)
        } else {
            content
                .offset(x: UIDevice.isIpad ? 0 : 0,
                        y: UIDevice.isIpad ? 0 : 0)
        }
        
    }
}
