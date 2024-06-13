//
//  IndexPointMarkFromHour.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import Foundation

func IndexPointMarkFromHour(offsetSec: Int) -> Int {
    return Int(FormatDateToString(date: Date(), format: "H", offsetSec: offsetSec))!
}
