//
//  FindChartDataTemperature.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 18/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataTemperature(weather: Weather,
                              date: Date,
                              option: EnumType) -> (new: [NewTemperature],
                                                    min: Double,
                                                    max: Double,
                                                    minIndex: Int,
                                                    maxIndex: Int,
                                                    rangeFrom: Int,
                                                    rangeTo: Int) {
    
    var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    var new: [NewTemperature] = []
    var min: Double = 0.00
    var max: Double = 0.00
    var minIndex: Int = 0
    var maxIndex: Int = 0
    var rangeFrom: Int = 0
    var rangeTo: Int = 0
    
    var tempInfo: [Temperature]
    
    let rangeTempMinValue =  15
    let rangeTempMaxValue =  15

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
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataTemperature",
                                                        weather: weather,
                                                        date: date,
                                                        option: option,
                                                        option1: .number24)
    tempInfo = value.5
    array.removeAll()
    new.removeAll()
    ///
    /// Må initialisere n:
    ///
    var n: NewTemperature = NewTemperature(type: "", hour: 0, value: 0.00, systemName: "")
    for i in 0..<tempInfo[tempType].data.count {
        array.append(tempInfo[tempType].data[i].temp)
        n.type = String(localized: "Temperature")
        n.hour = i
        n.value = tempInfo[tempType].data[i].temp
        n.systemName = tempInfo[tempType].data[i].symbolName
        new.append(n)
    }
    ///
    /// Tilhører Chart for aktuell temperatur:
    ///
    min  = array.min()!
    max  = array.max()!
    minIndex = array.firstIndex(of: array.min()!)!
    maxIndex = array.firstIndex(of: array.max()!)!
    ///
    ////Finner følt temperatur
    ///
    array.removeAll()
    for i in 0..<tempInfo[appearentType].data.count {
        array.append(tempInfo[appearentType].data[i].temp)
        n.type = String(localized: "Appearent temperature")
        n.hour = i
        n.value = tempInfo[appearentType].data[i].temp
        n.systemName = tempInfo[appearentType].data[i].symbolName
        new.append(n)
    }
    let tempMin = array.min()!
    let tempMax = array.max()!
    ///
    /// Beregner rangeFrom
    ///
    if tempMin <= min {
        rangeFrom = Int(tempMin) - rangeTempMinValue
    } else if tempMin > min {
        rangeFrom = Int(min) - rangeTempMinValue
    }
    ///
    /// Beregner rangeTo
    ///
    if tempMax <= max {
        rangeTo = Int(tempMax) + rangeTempMaxValue
    } else if tempMax > max {
        rangeTo = Int(max) + rangeTempMaxValue
    }
    
    rangeFrom = -10
    rangeTo = 30
    
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)

}
