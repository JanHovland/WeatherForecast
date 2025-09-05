//
//  DayDetailShowSelection.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/04/2023.
//

import SwiftUI

struct DayDetailShowSelection: View {
    
    var option: EnumType
    var xPos: CGFloat
    var selectedValue : SelectedValue

    var body: some View {
        ZStack {
            VStack {
                switch option {
                case .temperature :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -75 : -75))       /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 110 : 160))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .uvIndex :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -85 : -85))       /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 130 : 180))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .wind :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -67.5 : -70))     /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 110 : 160))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .feelsLike :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -75 : -70))       /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 110 : 160))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .humidity :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -50: -52))        /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 130 : 180))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .visibility :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -72.5: -82.5))    /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 130 : 180))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .airPressure :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -60 : -62.5))    /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 130 : 180))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                case .precipitation :
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -70 : -70))       /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 110 : 155))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                default:
                    Path { (path) in
                        path.move(to: .init(x: xPos, y: UIDevice.isIpad ? -90 : -85))       /// topp
                        path.addLine(to: .init(x: xPos, y: UIDevice.isIpad ? 100 : 150))    /// bunn
                    }
                    .stroke(lineWidth: 2)
                }
                VStack {
                    Text(selectedValue.time)
                        .font(.caption2)
                    HStack {
                        switch option {
                        case .temperature :
                            HStack (spacing: 0) {
                                HStack (spacing: 5) {
                                    Text("\(selectedValue.value1)")
                                    Text("\(selectedValue.value2)")
                                }
                                if selectedValue.icon.count > 0 {
                                    DayDetailAdaptSystemName(systemName: selectedValue.icon)
                                }
                            }
                        case .uvIndex :
                            HStack (spacing: 0) {
                                HStack (spacing: 5) {
                                    Text("\(selectedValue.value1)")
                                    Text("\(selectedValue.value2)")
                                }
                            }
                        case .wind :
                            HStack (spacing: 0) {
                                HStack (spacing: 2) {
                                    Text("\(selectedValue.value1)")
                                    Text("\(selectedValue.value3)")
                                    Text("\(selectedValue.value2)")
                                        .opacity(0.50)
                                }
                                if selectedValue.icon.count > 0 {
                                    DayDetailAdaptSystemName(systemName: selectedValue.icon)
                                }
                            }
                        case .feelsLike :
                            HStack (spacing: 0) {
                                HStack (spacing: 2) {
                                    Text("\(selectedValue.value1)")
                                }
                                if selectedValue.icon.count > 0 {
                                    DayDetailAdaptSystemName(systemName: selectedValue.icon)
                                }
                            }
                        case .humidity :
                            VStack (alignment: .leading){
                                Text("\(selectedValue.value1)")
                                HStack (spacing: 0) {
                                    Text("\(selectedValue.value2)")
                                    Text("\(selectedValue.value3)")
                                }
                                .font(.caption2)
                                .opacity(0.50)
                            }
                        case .airPressure :
                            VStack (alignment: .leading){
                                Text("\(selectedValue.value1)")
                                HStack (spacing: 0) {
                                    Text("\(selectedValue.value2)")
                                    Text("\(selectedValue.value3)")
                                }
                                .font(.caption2)
                                .opacity(0.50)
                            }
                        case .precipitation :
                            if selectedValue.icon.count > 0 {
                                DayDetailAdaptSystemName(systemName: selectedValue.icon)
                            }
                            VStack (alignment: .leading){
                                Text("\(selectedValue.value1)")
                                HStack (spacing: 0) {
                                    Text("\(selectedValue.value2)")
                                    Text("\(selectedValue.value3)")
                                }
                                .font(.caption2)
                                .opacity(0.50)
                            }
                        default:
                            HStack (spacing: 0) {
                                if selectedValue.icon.count > 0 {
                                    DayDetailAdaptSystemName(systemName: selectedValue.icon)
                                }
                                HStack (spacing: 5) {
                                    Text("\(selectedValue.value1)")
                                    Text("\(selectedValue.value2)")
                                }
                            }
                        }
                    }
                }
                ///
                /// Tilpasser posisjonen for selectedValue:
                ///
                .modifier(DayDetailPositionViewModifier(option: option, xPos: xPos))
                .font(.system(size: 22, weight: .light))
            }
        }
    }
}
