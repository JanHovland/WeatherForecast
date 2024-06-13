//
//  DayDetailChartYaxis.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/01/2023.
//

import SwiftUI

struct DayDetailChartYaxis: ViewModifier {
    
    var option: EnumType
    var from : Int
    var to: Int
    
    @ViewBuilder
    
    ///
    /// Endrer Y skalaen for :
    ///     .uvIndex,
    ///     .airPressure
    ///
    func body(content: Content) -> some View {
        if self.option == .humidity {
            content.chartYScale(domain: 0...100)
        } else {
            ///
            /// Tilpasse from og to:
            ///
            content.chartYScale(domain: from...to)
        }
    }
}
