//
//  DayDetailShowUnit.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/11/2022.
//

import Foundation

func showUnit (option: EnumType) -> String {
    
    switch option {
        
    case .dewPoint:
        return "º"         /// "ºC"
        
    case .temperature:
        return "º"         /// "ºC"
        
    case .wind :
        return " m/s"
        
    case .precipitation :
        return " mm"
        
    case .feelsLike :
        return "º"
        
    case .humidity :
        return " %"
        
    case .visibility :
        return " km"
        
    case .airPressure:
        return " hPa"
        
    default:
        return ""
    }
    
}
