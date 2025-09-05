//
//  FindChartDataHumidity.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataHumidity(weather: Weather,
                           date: Date,
                           option: EnumType) -> (new: [NewHumidity],
                                                 min: Double,
                                                 max: Double,
                                                 minIndex: Int,
                                                 maxIndex: Int,
                                                 rangeFrom: Int,
                                                 rangeTo: Int) {
    
    var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    var new: [NewHumidity] = []
    var min: Double = 0.00
    var max: Double = 0.00
    var minIndex: Int = 0
    var maxIndex: Int = 0
    let rangeFrom: Int = 0
    var rangeTo: Int = 0
    
    let rangeTempMaxValue =  20

    let value : ([Double],
                 [String],
                 [String],
                 [RainFall],
                 [WindInfo],
                 [Temperature],
                 [Double],
                 [WeatherIcon],
                 [Double],
                 [FeltTemp],
                 [Double],
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataHumidity",
                                                        weather: weather,
                                                        date: date,
                                                        option: option,
                                                        option1: .number24)
    array.removeAll()
    array = value.0
    new.removeAll()
    ///
    /// Må initialisere nOther:
    ///
    var n: NewHumidity = NewHumidity(type: "", hour: 0, value: 0.00)
    for i in 0..<array.count {
        n.type = String(localized: "Humidity")
        n.hour = i
        n.value = array[i]
        new.append(n)
    }
    min = array.min()!
    max = array.max()!
    minIndex = array.firstIndex(of: array.min()!)!
    maxIndex = array.firstIndex(of: array.max()!)!
    ///
    /// Beregner rangeTo
    ///
    rangeTo = Int(max) + rangeTempMaxValue
    
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)

}
