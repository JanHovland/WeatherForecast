//
//  FindChartDataWind.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 18/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataWind(weather: Weather,
                              date: Date,
                              option: EnumType) -> (new: [NewWind],
                                                    min: Double,
                                                    max: Double,
                                                    minIndex: Int,
                                                    maxIndex: Int,
                                                    rangeFrom: Int,
                                                    rangeTo: Int) {
    
    var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    var new: [NewWind] = []
    var min: Double = 0.00
    var max: Double = 0.00
    var minIndex: Int = 0
    var maxIndex: Int = 0
    var rangeFrom: Int = 0
    var rangeTo: Int = 0
    
    var tempInfo: [Temperature]
    
    let rangeGustMinValue =  9
    let rangeGustMaxValue =  9

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
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataWind",
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
    var n: NewWind = NewWind(type: "", hour: 0, value: 0.00)
    ///
    /// Finder windstyrken:
    ///
    for i in 0..<tempInfo[windType].data.count {
        array.append(tempInfo[windType].data[i].wind)
        n.type = String(localized: "Wind")
        n.hour = i
        n.value = tempInfo[windType].data[i].wind
        new.append(n)
    }
    ///
    /// Tilhører Chart for vindstyrken:
    ///
    min  = array.min()!
    max  = array.max()!
    minIndex = array.firstIndex(of: array.min()!)!
    maxIndex = array.firstIndex(of: array.max()!)!
    ///
    ///Finner vindkast:
    ///
    array.removeAll()
    for i in 0..<tempInfo[windType].data.count {
        array.append(tempInfo[windType].data[i].gust)
        n.type = String(localized: "GustSpeed")
        n.hour = i
        n.value = tempInfo[windType].data[i].gust
        new.append(n)
    }
    let gustMin = array.min()!
    let gustMax = array.max()!
    ///
    /// Beregner rangeFrom
    ///
    if gustMin <= min {
        rangeFrom = Int(gustMin) - rangeGustMinValue
    } else if gustMin > min {
        rangeFrom = Int(min) - rangeGustMinValue
    }
    ///
    /// Beregner rangeTo
    ///
    if gustMax <= max {
        rangeTo = Int(gustMax) + rangeGustMaxValue
    } else if gustMax > max {
        rangeTo = Int(max) + rangeGustMaxValue
        
    }
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)

}
