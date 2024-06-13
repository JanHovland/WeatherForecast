//
//  FindChartDataFeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 19/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataFeelsLike(weather: Weather,
                            date: Date,
                            option: EnumType) -> (new: [NewFeelsLike],
                                                        min: Double,
                                                        max: Double,
                                                        minIndex: Int,
                                                        maxIndex: Int,
                                                        rangeFrom: Int,
                                                        rangeTo: Int) {
     
    var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    var new: [NewFeelsLike] = []
    var min: Double = 0.00
    var max: Double = 0.00
    var minIndex: Int = 0
    var maxIndex: Int = 0
    var rangeFrom: Int = 0
    var rangeTo: Int = 0
    
    var tempInfo: [Temperature]
    
    let rangeTempFeelMinValue =  12
    let rangeTempFeelMaxValue =  12

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
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataFeelsLike",
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
    var n: NewFeelsLike = NewFeelsLike(type: "", hour: 0, value: 0.00)
    for i in 0..<tempInfo[tempType].data.count {
        array.append(tempInfo[tempType].data[i].temp)
        n.type = String(localized: "Appearent temperature")
        n.hour = i
        n.value = tempInfo[tempType].data[i].temp
        new.append(n)
    }
    ///
    /// Tilhører Chart for følt temperatur:
    ///
    min  = array.min()!
    max  = array.max()!
    minIndex = array.firstIndex(of: array.min()!)!
    maxIndex = array.firstIndex(of: array.max()!)!
    ///
    ///Finner aktuell temperatur:
    ///
    array.removeAll()
    for i in 0..<tempInfo[appearentType].data.count {
        array.append(tempInfo[appearentType].data[i].temp)
        n.type = String(localized: "Temperature")
        n.hour = i
        n.value = tempInfo[appearentType].data[i].temp
        new.append(n)
    }
    let feelslikeMin = array.min()!
    let feelslikeMax = array.max()!
    ///
    /// Beregner rangeFrom
    ///
    if feelslikeMin <= min {
        rangeFrom = Int(feelslikeMin) - rangeTempFeelMinValue
    } else if feelslikeMin > min {
        rangeFrom = Int(min) - rangeTempFeelMinValue
    }
    ///
    /// Beregner rangeTo
    ///
    if feelslikeMax <= max {
        rangeTo = Int(feelslikeMax) + rangeTempFeelMaxValue
    } else if feelslikeMax > max {
        rangeTo = Int(max) + rangeTempFeelMaxValue
    }
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)

}

