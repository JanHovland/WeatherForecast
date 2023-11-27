//
//  MenuTitleToOption.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2022.
//

import SwiftUI

func MenuTitleToOption(menuTitle: String) -> EnumType {
    
    switch menuTitle {
        
    case String(localized: "Temperature") :
        return .temperature
        
    case String(localized: "UV-index") :
        return .uvIndex
        
    case String(localized: "Wind") :
        return .wind
        
    case String(localized: "Rain") :
        return .precipitation
        
    case String(localized: "Feels like") :
        return .feelsLike
        
    case String(localized: "Humidity") :
        return .humidity
        
    case String(localized: "Visibility") :
        return .visibility
        
    case String(localized: "Air pressure") :
        return .airPressure
        
    default :
        return .temperature
    }
}
