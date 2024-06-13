//
//  DayDetailMenuDataViewOffsetViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/01/2023.
//

import SwiftUI

struct DayDetailMenuDataViewOffsetViewModifier: ViewModifier {
    let option: EnumType
    let index: Int

    @ViewBuilder
    func body(content: Content) -> some View {
        if self.option == .temperature {
            content.offset(x: UIDevice.isIpad ? 240  : 170,
                           y: UIDevice.isIpad ? -94  : -95)
        } else if self.option == .uvIndex {
            content.offset(x: UIDevice.isIpad ?  260 : 200,
                           y: UIDevice.isIpad ? -108 : -110)
        } else if self.option == .wind {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -106 : -108)
        } else if self.option == .feelsLike {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -108 : -108)
        } else if self.option == .humidity {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -92 : -90)
        } else if self.option == .visibility {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -91 : -90)
        } else if self.option == .airPressure {
            if index == 0 {
                content.offset(x: UIDevice.isIpad ?  260 : 170,
                               y: UIDevice.isIpad ? -108 : -108)
            } else {
                content.offset(x: UIDevice.isIpad ?  260 : 170,
                               y: UIDevice.isIpad ? -89 : -89)
            }
        } else {
            content.offset(x: UIDevice.isIpad ?  260 : 170,
                           y: UIDevice.isIpad ? -105 : -105)
        }
    }
}

