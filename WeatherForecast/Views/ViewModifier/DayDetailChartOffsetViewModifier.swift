//
//  DayDetailChartOffsetViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/01/2023.
//

import SwiftUI

struct DayDetailChartOffsetViewModifier: ViewModifier {
    let option: EnumType

    @ViewBuilder
    func body(content: Content) -> some View {
        if self.option == .humidity {
            content.offset(y: UIDevice.isIpad ? 60 : 160)
        } else {
            content.offset(y: UIDevice.isIpad ? 30 : 80)
        }
    }
}
