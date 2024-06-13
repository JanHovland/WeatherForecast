//
//  UvIndexDescription.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/12/2022.
//

import SwiftUI

func UvIndexDescription(uvIndex: Int) -> String {
    switch uvIndex {
    case 0...2:
        return String(localized: "Low level")
    case 3...5:
        return String(localized: "Moderate level")
    case 6...7:
        return String(localized: "High level")
    case 8...10:
        return String(localized: "Very high level")
    default:
        return String(localized: "Extreme level")
    }
}
