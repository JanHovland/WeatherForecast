//
//  ConvertImage.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2023.
//

import SwiftUI

func convertImageToFill(image: String) -> String {
    var imageOut : String = ""
    switch image {
        case "cloud.sun" : imageOut = "cloud.sun.fill"
        case "sun.max" : imageOut = "sun.max.fill"
        case "sun.horizon" : imageOut = "sun.horizon.fill"
        case "sun.dust" : imageOut = "sun.dust.fill"
        case "sun.haze" : imageOut = "sun.haze.fill"
        case "sun.rain" : imageOut = "sun.rain.fill"
        case "sun.snow" : imageOut = "sun.snow.fill"
        case "cloud.rain" : imageOut = "cloud.rain.fill"
        case "cloud.heavyrain" : imageOut = "cloud.heavyrain.fill"
        case "thermometer.sun" : imageOut = "thermometer.sun.fill"
        case "cloud.sun.rain" : imageOut = "cloud.sun.rain.fill"
        case "cloud.sun.bolt" : imageOut = "cloud.sun.bolt.fill"
        case "sun.max.trianglebadge.exclamationmark" : imageOut = "sun.max.trianglebadge.exclamationmark.fill"
        default: imageOut = image
    }
    return imageOut
}

