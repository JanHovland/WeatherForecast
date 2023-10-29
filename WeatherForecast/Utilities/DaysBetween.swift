//
//  DaysBetween.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/02/2023.
//

import Foundation


/// Finner dager mellom 2 datoer
/// - Parameters:
///   - start: Her legger du inn fra datoen
///   - end: Her legger du inn til datoen
/// - Returns: Antall dager mellom start og end datoene
func daysBetween(start: Date, end: Date) -> Int {
   return Calendar.current.dateComponents([.day], from: start, to: end).day!
}
 
