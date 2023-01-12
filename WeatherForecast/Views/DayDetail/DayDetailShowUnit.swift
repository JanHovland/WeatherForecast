//
//  DayDetailShowUnit.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/11/2022.
//

import Foundation

func showUnit (option: EnumType) -> String {
    
    switch option {
        
    case .temperature:
        return "ºC"  
        
    case .wind :
        return " m/s"
        
    case .precipitation :
        return " mm"
        
    case .feelsLike :
        return "º"
        
    case .humidity :
        return " %"
        
    case .visability :
        return " km"
        
    case .airPressure:
        return " hPa"
        
    default:
        return ""
    }
    
}
