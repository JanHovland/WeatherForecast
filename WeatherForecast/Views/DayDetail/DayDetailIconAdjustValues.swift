//
//  DayDetailIconAdjustValues.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/02/2024.
//

import SwiftUI

func DayDetailIconAdjustValues(option: EnumType, width: CGFloat) -> (CGFloat, CGFloat, CGFloat) {
    
    ///
    /// iPhone width: 368  eller  709   from GeometryReader
    /// iPad width:     809  eller 1087  from GeometryReader
    ///
    
    var fontSize: CGFloat = 0.00
    var spacing: CGFloat = 0.00
    var leading: CGFloat = 0.00
     
    if option == .temperature {
        if UIDevice.isiPhone {
            fontSize = 12
            if width < 709   { spacing = 10.5; leading = 35 } else { spacing = 39; leading = 35 }   // ??
        } else {
            fontSize = 15
            if width < 1087  { spacing = 42.5; leading = 38 } else { spacing = 66 ; leading = 8 }   // ??
        }
    } else if option == .uvIndex {
        if UIDevice.isiPhone {
            fontSize = 12
            if width < 709   { spacing = 20; leading = 15 } else { spacing = 45; leading = 40 }     // ok
        } else {
            fontSize = 15
            if width < 1087  { spacing = 55; leading = 40 } else { spacing = 75 ; leading = 62.5 }  // OK
        }
    }
    
    
    return (fontSize, spacing, leading)
    
}
