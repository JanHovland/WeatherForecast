//
//  FindDayOffsetFactor.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/02/2023.
//

import Foundation

///
/// Finner offset fra offsetString:
///     +01:00  -> 1
///     -01:00  -> -1
///
func FindDayOffsetFactor(_ offset: String) -> Int {
    var offsetValue: Int = 0
    if offset.count == 6 {
        let start = offset.index(offset.startIndex, offsetBy: 0)
        let range = start...start
        let sign = String(offset[range])
        let start1 = offset.index(offset.startIndex, offsetBy: 1)
        let end1 = offset.index(offset.endIndex, offsetBy: -4)
        let range1 = start1...end1
        let value = String(offset[range1])
        if sign == "-" {
            offsetValue = (Int(value)! * -1)
        } else {
            offsetValue = Int(value)!
        }
    }
    return offsetValue
}
