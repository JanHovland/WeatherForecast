//
//  DayDetailHourIcons.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 19/11/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailHourIcons: View {
    
    let option: EnumType
    let index: Int
    let weather: Weather
    let date: Date
    @Binding var hourIconArray: [String]
    
    @State private var spacing: CGFloat = 0.00
    @State private var fontSize: CGFloat = 0.00
    @State private var padding: CGFloat = 0.00
    
    var body: some View {
        if option == .temperature {
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 6.50
                } else {
                    spacing = 0.20
                    fontSize = 15
                    padding = 11.25
                }
            }
        } else if option == .uvIndex {
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 12
                    fontSize = 15
                    padding = 10.25
                }
            }
        } else if option == .wind {
            HStack (spacing: spacing) {
                ForEach(Array(hourIconArray.enumerated()), id: \.element) { idx, element in
                    VStack {
                        if let degrees = Double(element) {
                            ///
                            /// Siden det ikke finnes et symbol som heter "location.siuth.fill" roteres "location.north.fill" 180º ekstra:
                            ///
                            Image(systemName: "location.north.fill")
                                .rotationEffect(Angle(degrees: degrees + 180), anchor: .center)
                                .font(.system(size: fontSize))
                                .foregroundColor(.primary)
                                .padding(.horizontal, padding)
                        }
                    }
                }
            }
            .task {
                if UIDevice.isiPhone {
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 5
                    fontSize = 15
                    padding = 10.25
                }
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 0.20
                    fontSize = 15
                    padding = 10.25
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 12
                    fontSize = 15
                    padding = 5.5
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 12
                    fontSize = 15
                    padding = 5.5  
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
                    spacing = -1.5
                    fontSize = 12.5
                    padding = 7
                } else {
                    spacing = 0.20
                    fontSize = 15
                    padding = 12.5
                }
            }
        }
    }
}
 
