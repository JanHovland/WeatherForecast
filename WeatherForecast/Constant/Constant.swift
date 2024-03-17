//
//  Constant.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/08/2023.
//

import Foundation

let windType: Int = 0
let gustType: Int = 1

let tempType: Int = 0
let appearentType: Int = 1

let uvIconType: Int = 0
let windIconType: Int = 1
let humidityIconType: Int = 2
let visibilityIconType: Int = 3
let airpressureIconType: Int = 4

let rainType: Int = 0
let sleetType: Int = 1
let mixedType: Int = 2
let snowType: Int = 3
let hailType: Int = 4
///
/// Constant for Air Quality:
///

/// https://www.compart.com/en/unicode/U+00B3
/// https://www.compart.com/en/unicode/block/U+0080
/// https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts#Superscripts_and_subscripts_block

let aqUnit: String = "μg/m\u{00B3}"
let SO2: String = "SO\u{2082}"
let NO2: String = "NO\u{2082}"
let PM10: String = "PM\u{2081}\u{2080}"
let PM2_5: String = "PM\u{2082}\u{208B}\u{2085}"
let O3: String = "O\u{2083}"
let NH3: String = "NO\u{2083}"

///
/// Størrelsene for diverse array :
///

let sizeArray10: Int = 10
let sizeArray12: Int = 12
let sizeArray13: Int = 13
let sizeArray24: Int = 24


let aqSO2: String = String(localized: "Sulphur dioxide")
let aqNO2: String = String(localized: "Nitrogen dioxide")
let aqPM: String = String(localized: "Particulates")
let aqO3: String = String(localized: "Ozone")
let aqCO: String = String(localized: "Carbon monoxide CO")

