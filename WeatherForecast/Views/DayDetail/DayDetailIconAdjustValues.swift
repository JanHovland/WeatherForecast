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
    var offset: CGFloat = 0.00
     
    if option == .temperature {
        if UIDevice.isiPhone {
            fontSize = 11
            if width < 709   { spacing = 11; offset = 20 }   else { spacing = 39; offset = 35 }     // OK
        } else {
            fontSize = 15
            if width < 1087  { spacing = 42.5; offset = 38 } else { spacing = 66; offset = 45 }     // OK
        }
    } else if option == .uvIndex {
        if UIDevice.isiPhone {
            fontSize = 14
            if width < 709   { spacing = 20; offset = 15 }   else { spacing = 45; offset = 25 }     // OK
        } else {
            fontSize = 15
            if width < 1087  { spacing = 53; offset = 42.5 } else { spacing = 77.5; offset = 55 }   // OK
        }
    } else if option == .wind {
        if UIDevice.isiPhone {
            fontSize = 11
            if width < 709   { spacing = 15; offset = 20 }   else { spacing = 44; offset = 35 }     // OK
        } else {
            fontSize = 15
            if width < 1087  { spacing = 47.5; offset = 38 } else { spacing = 70; offset = 45 }     // OK
        }

    }
    
    
    return (fontSize, spacing, offset)
    
}
