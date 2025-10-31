//
//  FindChartDataPrecipitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataPrecipitation(weather: Weather,
                                date: Date,
                                option: EnumType) -> (new: [NewPrecipitation],
                                                      min: Double,
                                                      max: Double,
                                                      minIndex: Int,
                                                      maxIndex: Int,
                                                      rangeFrom: Int,
                                                      rangeTo: Int) {
    
    var new: [NewPrecipitation] = []
    let min: Double = 0.00
    var max: Double = 0.00
    let minIndex: Int = 0
    let maxIndex: Int = 0
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
                 [NewPrecipitation]) = FindDataFromMenu(info: "FindChartDataPrecipitation",
                                                        weather: weather,
                                                        date: date,
                                                        option: option,
                                                        option1: .number24)
    
    new = value.10
    ///
    /// Finner max:
    ///
    for i in 0...23 {
        if new[i].value > max {
            max = new[i].value
        }
    }
    ///
    /// Beregner rangeFrom
    ///
    rangeFrom = 0
    ///
    /// Må beregne rangeTo som er den  maksibale verdien av alle typene
    ///
    rangeTo = Int(max) + 1
    
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)
}
