//
//  MenuContent.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/10/2022.
//

import SwiftUI
import WeatherKit

/// https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-menu-when-a-button-is-pressed
/// Show context menu in SwiftUI on tap:
/// https://developer.apple.com/forums/thread/651036

struct MenuContent: View {
    
    @Binding var menuIcon : String
    @Binding var menuTitle : String
   
    var body: some View {
        
        Button(action: {
            Task.init {
                menuIcon = "cloud.sun.rain.fill"
                menuTitle = String(localized: "Weather conditions")
            }
        }) {
            HStack {
                Image(systemName: "cloud.sun.rain.fill")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Weather conditions"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "sun.max"
                menuTitle = String(localized: "UV-index")
            }
        }) {
            HStack {
                Image(systemName: "sun.max")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "UV-index"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "wind"
                menuTitle = String(localized: "Wind")
            }
        }) {
            HStack {
                Image(systemName: "wind")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Wind"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "drop"
                menuTitle = String(localized: "Rain")
            }
        }) {
            HStack {
                Image(systemName: "drop")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Rain"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "thermometer.medium"
                menuTitle = String(localized: "Feels like")
            }
        }) {
            HStack {
                Image(systemName: "thermometer.medium")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Feels like"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "humidity"
                menuTitle = String(localized: "Humidity")
            }
        }) {
            HStack {
                Image(systemName: "humidity")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Humidity"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "eye"
                menuTitle = String(localized: "Visibility")
            }
        }) {
            HStack {
                Image(systemName: "eye")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Visibility"))
            }
        }
        
        Button(action: {
            Task.init {
                menuIcon = "gauge.medium"
                menuTitle = String(localized: "Air pressure")
            }
        }) {
            HStack {
                Image(systemName: "gauge.medium")
                    .symbolRenderingMode(.multicolor)
                Text(String(localized: "Air pressure"))
            }
        }
    }
    
}

