//
//  AirQualityInformationViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/11/2023.
//

import SwiftUI
import Foundation

struct AirQualityInformationViewModifier: ViewModifier {
    let index: EnumType

    @ViewBuilder
    
    func body(content: Content) -> some View {
        
        if index == .firstEnum {
            content
                .foregroundColor(.black)
                .background(Color("LightYellow"))
        } else if index == .secondEnum {
            content
                .padding(-20)
                .listStyle(.grouped)
                .frame(height: 150)
        } 
    }
}
