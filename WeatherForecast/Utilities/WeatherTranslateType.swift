//
//  WeatherTranslateType.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/12/2022.
//

import Foundation

func WeatherTranslateType(type: String) -> String {
    
    switch type {
        
    case "Sludd" :
        return String(localized: "snowy weather")
        
    case "Snø" :
        return String(localized: "snowy weather")
        
    case "Hagl" :
        return String(localized: "snowy weather")
        
    case "Blandet nedbør" :
        return String(localized: "snowy weather")
        
    case "Yr" :
        return String(localized: "rainy weather")
        
    case "Regn" :
        return String(localized: "rainy weather")
        
    case "Duskregn" :
        return String(localized: "rainy weather")
        
    case "Underkjølt duskregn" :
        return String(localized: "rainy weather")
        
    case "Underkjølt regn" :
        return String(localized: "rainy weather")
        
    default:
        return String(localized: "no weather info")
    }
}

