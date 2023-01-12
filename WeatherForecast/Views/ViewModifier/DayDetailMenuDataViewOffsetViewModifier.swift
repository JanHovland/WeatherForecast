//
//  DayDetailMenuDataViewOffsetViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/01/2023.
//

import SwiftUI

struct DayDetailMenuDataViewOffsetViewModifier: ViewModifier {
    let option: EnumType

    @ViewBuilder
    func body(content: Content) -> some View {
        if self.option == .temperature {
            content.offset(x: UIDevice.isIpad ? 260  : 170,
                           y: UIDevice.isIpad ? -95  : -95)
        } else {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -105 : -105)
        }
    }
}

