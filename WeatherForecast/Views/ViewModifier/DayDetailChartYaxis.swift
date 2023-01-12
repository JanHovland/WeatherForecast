//
//  DayDetailChartYaxis.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/01/2023.
//

import SwiftUI

struct DayDetailChartYaxis: ViewModifier {
    
    var option: EnumType
    
    @ViewBuilder
    
    ///
    /// Endrer Y skalaen for :
    ///     .uvIndex,
    ///     .airPressure
    ///
    func body(content: Content) -> some View {
        if self.option == .airPressure {
            ///
            /// Høyeste lufttrykk registrert i Norge er 1061 hPa (Dalen i Telemark, 23. januar 1907)
            /// Laveste er 938 hPa (Skudenes, 20. februar 1907).
            ///
            content.chartYScale(domain: 980...1020)
        } else if self.option == .uvIndex {
            content.chartYScale(domain: 0...10)
        } else {
            ///
            /// Ingen endring:
            ///
            content.chartYScale()
        }
    }
}
