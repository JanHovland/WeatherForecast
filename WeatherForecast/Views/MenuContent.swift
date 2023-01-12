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
    
    @Binding var menuSystemName : String
    @Binding var menuTitle : String
   
    var body: some View {
        
        Button(action: {
            Task.init {
                menuSystemName = "thermometer.medium"
                menuTitle = String(localized: "Temperature")
            }
        }) {
            HStack {
                Image(systemName: "thermometer.medium")
                Text(String(localized: "Temperature"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "sun.max"
                menuTitle = String(localized: "UV-index")
            }
        }) {
            HStack {
                Image(systemName: "sun.max")
                Text(String(localized: "UV-index"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "wind"
                menuTitle = String(localized: "Wind")
            }
        }) {
            HStack {
                Image(systemName: "wind")
                Text(String(localized: "Wind"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "drop"
                menuTitle = String(localized: "Rain")
            }
        }) {
            HStack {
                Image(systemName: "drop")
                Text(String(localized: "Rain"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "thermometer.medium"
                menuTitle = String(localized: "Feels like")
            }
        }) {
            HStack {
                Image(systemName: "thermometer.medium")
                Text(String(localized: "Feels like"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "humidity"
                menuTitle = String(localized: "Humidity")
            }
        }) {
            HStack {
                Image(systemName: "humidity")
                Text(String(localized: "Humidity"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "eye"
                menuTitle = String(localized: "Visability")
            }
        }) {
            HStack {
                Image(systemName: "eye")
                Text(String(localized: "Visability"))
            }
        }
        
        Button(action: {
            Task.init {
                menuSystemName = "gauge.medium"
                menuTitle = String(localized: "Air pressure")
            }
        }) {
            HStack {
                Image(systemName: "gauge.medium")
                Text(String(localized: "Air pressure"))
            }
        }
    }
    
}

