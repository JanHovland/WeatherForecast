//
//  CountryName.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/01/2024.
//

import SwiftUI

struct CountryName : ViewModifier { 
    var name : String
    var length: Int
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if UIDevice.isiPhone {
            if name.count > length {
                content
                    .font(.footnote)
            }
            else {
                content
            }
        } else {
            content
        }
    }
}
