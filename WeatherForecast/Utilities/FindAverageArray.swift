//
//  FindAverageArray.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/01/2023.
//

import Foundation

func FindAverageArray(array: [Double]) -> Double {
    let sum = array.reduce(0,+)
    let length = array.count
    return Double(sum)/Double(length)
}
