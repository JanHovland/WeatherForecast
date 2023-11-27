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
            
        case "sun.max.fill",
             "sun.max.trianglebadge.exclamationmark",
             "sun.max.trianglebadge.exclamationmark.fill",
             "sunrise.fill",
             "sunset.fill",
             "sun.and.horizon.fill",
             "sun.dust.fill",
             "sun.haze.fill",
             "sparkles",
             "cloud.sun.fill",
             "cloud.sun.bolt.fill",
             "thermometer.sun.fill",
             "aqi.high":
            Image(systemName:"\(systemName)")
                .symbolRenderingMode(.multicolor)
//                .foregroundStyle(.primary, Color.yellow)
            
        default:
            Image(systemName:"\(systemName)")
//                .symbolRenderingMode(.palette)
                .symbolRenderingMode(.multicolor)
//                .foregroundStyle(.primary, Color.accentColor)
        }
    }
}


