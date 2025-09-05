//
//  GetFlag.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/01/2024.
//

import SwiftUI
///
/// Finne flagget til et land ut fra landskoden på 2 tegn
///

func GetFlag(countryCode: String) -> String {
    let base : UInt32 = 127397
    var s = ""
    if countryCode.count == 2 {
        for v in countryCode.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
    }
    
    return s
}
