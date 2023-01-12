//
//  DayDetailHourIcons.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 19/11/2022.
//

import SwiftUI

struct DayDetailHourIcons: View {
    
    let option: EnumType
    @Binding var iconArray: [String]
    
    @Binding var uvIndexArray: [String]
    @Binding var windArray: [String]
    @Binding var humidityArray: [String]
    @Binding var visabilityArray: [String]
    @Binding var airpressureArray: [String]
    
    @State private var spacing: CGFloat = 0.00
    @State private var fontSize: CGFloat = 0.00
    @State private var padding: CGFloat = 0.00
    
    var body: some View {
        
        if option == .temperature ||
            option == .precipitation ||
            option == .feelsLike {
            HStack (spacing: spacing) {
                ForEach(Array(iconArray.enumerated()), id: \.element) { idx, element in
                    VStack {
                        Image(systemName: "\(element.description)")
                            .font(.system(size: fontSize))
                            .environment(\.symbolVariants, .none)
                            .symbolRenderingMode(.multicolor)
                            .padding(.horizontal, padding)
                    }
                }
            }
            .task {
                if UIDevice.isiPhone {
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 2
                    fontSize = 15
                    padding = 10
                }
            }
        }
        if option == .uvIndex {
            ///
            /// Viser iconene for uvIndex:
            ///
            iconUvIndexView(uvIndexArray: $uvIndexArray,
                            spacing:  UIDevice.isIpad ?  8.75  : 6,
                            fontSize: UIDevice.isIpad ? 15  : 14,
                            padding: UIDevice.isIpad  ? 12  : 7)
        } else if option == .wind {
            ///
            /// Viser iconene for vinden:
            ///
            iconWindView(windArray: $windArray,
                         spacing:  UIDevice.isIpad ? 8.75 : 3,
                         fontSize: UIDevice.isIpad ? 14  : 12,
                         padding: UIDevice.isIpad  ? 10  : 7)
        } else if option == .humidity {
            ///
            /// Viser iconene for luftfuktighet:
            ///
            IconHumidityView(humidityArray: $humidityArray,
                             spacing:  UIDevice.isIpad ? -5 : -3.5,
                             fontSize: UIDevice.isIpad ? 12  : 10,
                             padding: UIDevice.isIpad  ? 10  : 5)
        } else if option == .visability {
            ///
            /// Viser iconene for sikt:
            ///
            IconVisibilityView(visabilityArray: $visabilityArray,
                               spacing:  UIDevice.isIpad ? -6.5 : -3.25,
                               fontSize: UIDevice.isIpad ? 12   :  9,
                               padding: UIDevice.isIpad  ? 10   :  5)
        } else if option == .airPressure {
            ///
            /// Viser iconene for lufttrykk:
            ///
            IconAirPressureView(airpressureArray: $airpressureArray,
                                spacing:  UIDevice.isIpad ? 5.5 : 5.25,
                                fontSize: UIDevice.isIpad ? 15   : 13,
                                padding: UIDevice.isIpad  ? 10   :  5)
        }
    }
}

