//
//  FindAverageYear.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/03/2024.
//

import Foundation
import SwiftUI

func FindAverageYear(averageDailyTime: [String],
                     avarageDailyMin: [Double],
                     avarageDailyMax: [Double],
                     averageDailyMean: [Double],
                     aveargePercification: [Double]) -> ([Double],
                                                         [Double],
                                                         [Double],
                                                         [Double]) {
    
    var valueMin = [Double]()
    var valueMax = [Double]()
    var valueMean = [Double]()
    var valuePrecification = [Double]()
    var valueSum = Double()
    var monthSelected: String = ""
    var averageDailyTemperatureMin = [Double]()
    var averageDailyTemperatureMax = [Double]()
    var averageDailyTemperatureMean = [Double]()
    var averageDailyPrecipitation = [Double]()
    ///
    /// Finding monthly data
    ///
    for month in 1...12 {
        ///
        /// Resetting 
        ///
        averageDailyTemperatureMin.removeAll()
        averageDailyTemperatureMax.removeAll()
        averageDailyTemperatureMean.removeAll()
        averageDailyPrecipitation.removeAll()
        valueSum = 0.00
        ///
        /// Formattering:
        ///
        if month < 10 {
            monthSelected = "-0" + String(month) + "-"
        } else {
            monthSelected = "-" + String(month) + "-"
        }
        ///
        /// Finding data for a **specific** month:
        ///
        for i in 0..<averageDailyTime.count {
            if averageDailyTime[i].contains(monthSelected) {
                averageDailyTemperatureMin.append(avarageDailyMin[i])
                averageDailyTemperatureMax.append(avarageDailyMax[i])
                averageDailyTemperatureMean.append(averageDailyMean[i])
                averageDailyPrecipitation.append(aveargePercification[i])
                valueSum += aveargePercification[i]
            }
        }
        valueMin.append(FindAverageArray(array: averageDailyTemperatureMin))
        valueMax.append(FindAverageArray(array: averageDailyTemperatureMax))
        valueMean.append(FindAverageArray(array: averageDailyTemperatureMean))
        valuePrecification.append(valueSum / 30.00)
    }
    ///
    /// Eksport  på ** hver** av de 12 månedene
    ///
    return (valueMin, valueMax, valueMean, valuePrecification)
}

