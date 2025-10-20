//
//  DayDetailShowUnit.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/11/2022.
//

import Foundation

func ShowUnit (option: EnumType) -> String {
    
    switch option {
        
    case .dewPoint:
        return "º C"         /// "ºC"
        
    case .temperature:
        return "º C"         /// "ºC"
        
    case .wind :
        return " m/s"
        
    case .precipitation :
        return " mm"
        
    case .feelsLike :
        return "º C"
        
    case .humidity :
        return " %"
        
    case .visibility :
        return " km"
        
    case .airPressure:
        return " hPa"
        
    case .probability:
        return " %"

    default:
        return ""
    }
    
}
