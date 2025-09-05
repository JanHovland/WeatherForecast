//
//  MoonRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/11/2023.
//

import SwiftUI

struct MoonRecord {
    var moonrise: String = ""       ///  vises som:   "10:37 PM"
    var moonset: String = ""        ///  vises som:   "03:46 PM"
    var moonPhase: String = ""      ///  vises som:   "Last Quarter"
    var moonIllumination: Int = 0   ///  vises som:   53 som er 53 %
    var isMoonUp: Int = 0           ///  vises som:     1 som er true
    var isSunUp: Int = 0            ///  vises som:     0 som er false
}
