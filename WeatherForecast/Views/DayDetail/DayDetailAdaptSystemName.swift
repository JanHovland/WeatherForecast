//
//  DayDetailAdaptSystemName.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/11/2022.
//

import SwiftUI

/// https://www.hackingwithswift.com/books/ios-swiftui/custom-modifiers

struct DayDetailAdaptSystemName: View {
    
    let systemName: String
    
    var body: some View {
        switch systemName {
            
        case "cloud.sun" :
            Image(systemName:"\(systemName)")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.primary, Color.yellow)
            
        case "sun.max" :
            Image(systemName:"\(systemName)")
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(Color.yellow)
            
        default:
            Image(systemName:"\(systemName)")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.primary, Color.blue, Color.yellow)
        }
    }
}


