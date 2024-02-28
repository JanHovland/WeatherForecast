//
//  DayDetailIconAdjustValues.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/02/2024.
//

import SwiftUI

func DayDetailIconAdjustValues(option: EnumType, width: CGFloat) -> (CGFloat, CGFloat, CGFloat) {
    
    ///
    /// iPhone:  368 x  709   from GeometryReader
    /// iPad:      809 x 1087  from GeometryReader
    ///
    
    var fontSize: CGFloat = 0.00
    var spacing: CGFloat = 0.00
    var trailing: CGFloat = 0.00
     
    if option == .temperature {
        if UIDevice.isiPhone {
            fontSize = 12
            if width < 709   { spacing = 10.5; trailing = 35 } else { spacing = 39; trailing = 35 }
        } else {
            fontSize = 15
            if width < 1087  { spacing = 42.5; trailing = 38 } else { spacing = 66 ; trailing = 38 }
        }
    }

    
    
    return (fontSize, spacing, trailing)
    
}
