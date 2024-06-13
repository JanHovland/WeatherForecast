//
//  AdjustOffset.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/01/2023.
//

import SwiftUI
import Foundation

///
/// Tilpasser offset : "+0100" -> "01:00"
///
func AdjustOffset(_ offset: String) -> (String) {
    
    var a: String = ""
    var b: String = ""
    var c: String = ""
    
    if offset.count == 5 {
        let start = offset.index(offset.startIndex, offsetBy: 0)
        let end = offset.index(offset.endIndex, offsetBy: -2)
        let range = start..<end
        a = String(offset[range])
        let start1 = offset.index(offset.startIndex, offsetBy: 3)
        let end1 = offset.index(offset.endIndex, offsetBy: 0)
        let range1 = start1..<end1
        b = String(offset[range1])
        c = a + ":" + b
        return c
    } else {
        return offset
    }
}
