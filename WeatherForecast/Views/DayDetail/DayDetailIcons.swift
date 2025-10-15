//
//  DayDetailIcons.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 19/11/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailIcons: View {
    
    let option: EnumType
    let index: Int
    let weather: Weather
    @Binding var hourIconArray: [String]
    let width: Double
    
    @State private var spacing: CGFloat = 0.00
    @State private var fontSize: CGFloat = 0.00
    @State private var padding: CGFloat = 0.00
    @State private var trailing: CGFloat = 0.00 // må fjernes
    @State private var leading: CGFloat = 0.00
    @State private var offset: CGFloat = 0.00
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var o: Int = 0

    var body: some View {
        VStack {
             if option == .temperature {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Image(systemName: convertImageToFill(image: element.description))
                                .font(.system(size: fontSize))
                                .modifier(ImageViewModifier(image: convertImageToFill(image: element.description)))
                        }
                    }
                    Spacer()
                }
                .offset(x: offset)
                .task {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
                }
                .onChange(of: screenWidth) {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
               }

            } else if option == .uvIndex {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Text("\(element.description)")
                                .font(.system(size: fontSize))
                        }
                    }
                    Spacer()
                }
                .offset(x: offset)
                .task {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
                }
                .onChange(of: screenWidth) {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
               }
                
            } else if option == .wind {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            if let degrees = Double(element) {
                                ///
                                /// Siden det ikke finnes et symbol som heter "location.south.fill" roteres "location.north.fill" 180º ekstra:
                                ///
                                Image(systemName: "location.north.fill")
                                    .rotationEffect(Angle(degrees: degrees + 180), anchor: .center)
                                    .font(.system(size: fontSize))
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, padding)
                            }
                        }
                    }
                    Spacer()
                }
                .offset(x: offset)
                .task {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
                }
                .onChange(of: UIDevice.current.orientation) {
                    (fontSize, spacing, offset) = DayDetailIconAdjustValues(option: option)
               }
                
            } else if option == .feelsLike {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Image(systemName: "\(element.description)")
                                .font(.system(size: fontSize))
                                .symbolRenderingMode(.multicolor)
                                .padding(.horizontal, padding)
                        }
                    }
                }
                .task {
                    if UIDevice.isiPhone {
//                        spacing = 2
                        fontSize = 11.5
                        padding = 5.5
                    } else {
//                        spacing = 1
                        fontSize = 15
                        padding = 10.65
                    }
                }
            } else if option == .visibility {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Text("\(element.description)")
                                .font(.system(size: fontSize))
                                .symbolRenderingMode(.multicolor)
                                .padding(.horizontal, padding)
                        }
                    }
                }
                .task {
                    if UIDevice.isiPhone {
//                        spacing = 1
                        fontSize = 13
                        padding = 5.50
                    } else {
//                        spacing = 9
                        fontSize = 15
                        padding = 7.50
                    }
                }
            } else if option == .humidity {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Text("\(element.description)")
                                .font(.system(size: fontSize))
                                .symbolRenderingMode(.multicolor)
                                .padding(.horizontal, padding)
                        }
                    }
                }
                .task {
                    if UIDevice.isiPhone {
//                        spacing = 2.0
                        fontSize = 12.5
                        padding = 4.75
                    } else {
//                        spacing = 13
                        fontSize = 15
                        padding = 5.0
                    }
                }
            } else if option == .airPressure {
                HStack (spacing: spacing) {
                    ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                        VStack {
                            Image(systemName: "\(element.description)")
                                .font(.system(size: fontSize))
                                .symbolRenderingMode(.multicolor)
                                .padding(.horizontal, padding)
                        }
                    }
                }
                .task {
                    if UIDevice.isiPhone {
//                        spacing = 1
                        fontSize = 14
                        padding = 5.75
                    } else {
//                        spacing = 1
                        fontSize = 17
                        padding = 11.25
                    }
                }
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: 50)
        .padding(.vertical, 20)
    }
    
}
 
