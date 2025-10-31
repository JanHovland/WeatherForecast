//
//  FindChartDataAirPressure.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataAirPressure(weather: Weather,
                              date: Date,
                              option: EnumType) -> (new: [NewAirPressure],
                                                    min: Double,
                                                    max: Double,
                                                    minIndex: Int,
                                                    maxIndex: Int,
                                                    rangeFrom: Int,
                                                    rangeTo: Int) {
            
    var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    var new: [NewAirPressure] = []
    var min: Double = 0.00
    var max: Double = 0.00
    var minIndex: Int = 0
    var maxIndex: Int = 0
    var rangeFrom: Int = 0
    var rangeTo: Int = 0

    let value : ([Double],
                 [String],
                 [String],
                 [WindInfo],
                 [Temperature],
                 [Double],
                 [WeatherIcon],
                 [Double],
                 [FeltTemp],
                 [Double],
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataAirPressure",
                                                        weather: weather,
                                                        date: date,
                                                        option: option,
                                                        option1: .number24)
    array.removeAll()
    array = value.0
    new.removeAll()
    ///
    /// Må initialisere n:
    ///
    var n: NewAirPressure = NewAirPressure(type: "", hour: 0, value: 0.00)
    for i in 0..<array.count {
        n.type = String(localized: "AirPressure")
        n.hour = i
        n.value = array[i]
        new.append(n)
    }
    min = array.min()!
    max = array.max()!
    minIndex = array.firstIndex(of: array.min()!)!
    maxIndex = array.firstIndex(of: array.max()!)!
    ///
    /// Beregner rangeFrom
    ///
    rangeFrom = 945
    
    if Int(min) < rangeFrom {
        rangeFrom = Int(min)
    }
    ///
    /// Beregner rangeTo
    ///
    rangeTo = 1060
    
    if Int(max) > rangeTo {
        rangeTo = Int(max)
    }
    
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)

}
