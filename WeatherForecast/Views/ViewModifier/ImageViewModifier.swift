//
//  ImageViewModifier.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2023.
//

import SwiftUI

struct ImageViewModifier: ViewModifier {
    let image: String
    @ViewBuilder
    func body(content: Content) -> some View {
        switch image {
        case "cloud.sun.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.max.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.horizon.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.dust.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.haze.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.rain.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.snow.fill" : content.symbolRenderingMode(.multicolor)
        case "cloud.rain.fill" : content.symbolRenderingMode(.multicolor)
        case "cloud.heavyrain.fill" : content.symbolRenderingMode(.multicolor)
        case "thermometer.sun.fill" : content.symbolRenderingMode(.multicolor)
        case "cloud.sun.rain.fill" : content.symbolRenderingMode(.multicolor)
        case "cloud.sun.bolt.fill" : content.symbolRenderingMode(.multicolor)
        case "sun.max.trianglebadge.exclamationmark.fill" : content.symbolRenderingMode(.multicolor)
        default: content.symbolRenderingMode(.palette).foregroundStyle(.white, .blue)
        }
    }
}
 
