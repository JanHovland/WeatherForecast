//
//  FindMenySystemImage.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/11/2023.
//

import SwiftUI

func FindMenySystemImage(menuTitle: String) -> String {
    var image: String = ""
    
    if menuTitle == String(localized: "Weather conditions") {
        image = "cloud.sun.rain.fill"
    } else if menuTitle == String(localized: "UV-index") {
        image = "sun.max"
    } else if menuTitle == String(localized: "Wind")  {
        image = "wind"
    } else if menuTitle == String(localized: "Rain") {
        image = "drop"
    } else if menuTitle == String(localized: "Feels like") {
        image = "thermometer.medium"
    } else if menuTitle == String(localized: "Humidity") {
        image = "humidity"
    } else if menuTitle == String(localized: "Visibility") {
        image = "eye"
    } else if menuTitle == String(localized: "Air pressure") {
        image = "gauge.medium"
    }
    return image
}

