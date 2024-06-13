//
//  Precipitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2023.
//

import SwiftUI

//struct PrecificationLast24h {
//    var rainLast24: Double = 0.00
//    var snowLast24: Double = 0.00
//    var hailLast24: Double = 0.00
//    var mixedLast24: Double = 0.00
//    var sleetLast24: Double = 0.00
//}
//
//struct PrecificationNext24h {
//    var rainNext24: Double = 0.00
//    var snowNext24: Double = 0.00
//    var hailNext24: Double = 0.00
//    var mixedNext24: Double = 0.00
//    var sleetNext24: Double = 0.00
//}

struct Precipitation {
    ///
    /// Verdier for index == 0
    ///
    var rainLast24: Double = 0.00
    var snowLast24: Double = 0.00
    var hailLast24: Double = 0.00
    var mixedLast24: Double = 0.00
    var sleetLast24: Double = 0.00
    var rainNext24: Double = 0.00
    var snowNext24: Double = 0.00
    var hailNext24: Double = 0.00
    var mixedNext24: Double = 0.00
    var sleetNext24: Double = 0.00
    ///
    /// Verdier for de neste dagene
    ///
    var rainThisDay: Double = 0.00
    var snowThisDay: Double = 0.00
    var hailThisDay: Double = 0.00
    var mixedThisDay: Double = 0.00
    var sleetThisDay: Double = 0.00

}
