//
//  GetBaseDate.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/03/2023.
//

import Foundation

///
/// Finner datoen der offsetSec == 0
/// Ut fra den datoen settes andre datoer
///

func getBaseDate() -> Date {
    return Date().adding(seconds: -Date().localOffset())
}
