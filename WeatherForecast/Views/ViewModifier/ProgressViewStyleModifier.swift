    //
    //  ProgressViewStyleModifier.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 01/12/2023.
    //

import SwiftUI

struct ProgressViewStyleModifier: ProgressViewStyle {
    var option: EnumType
    var valueToDay: Double
    var valueYesterDay: Double
    var factorToDay: CGFloat
    var factorYesterDay: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geo  in
            VStack (alignment: .leading) {
                
                HStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: (geo.size.width - (UIDevice.isIpad ? 70 : 70)) * factorToDay, height: 20)
                            .foregroundColor(.white)
                            .overlay (
                                HStack {
                                    Text("I dag")
                                        .foregroundStyle(.black)
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                            )
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        if option == .wind {
                            Text("\(valueToDay,specifier: "%.1f") m/s")
                        } else if option == .uvIndex {
                            Text("\(Int(valueToDay))")
                        } else if option == .humidity {
                            Text("\(valueToDay,specifier: "%.1f") %")
                        } else if option == .temperature {
                            Text("\(valueToDay,specifier: "%.1f") ºC")
                        } else {
                            Text("\(valueToDay, specifier: "%.1f")")
                        }
                    }
                }
                HStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: (geo.size.width - (UIDevice.isIpad ? 70 : 70)) * factorYesterDay, height: 20)
                            .foregroundColor(.gray)
                            .overlay (
                                HStack {
                                    Text("I går")
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                            )
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        if option == .wind {
                            Text("\(valueYesterDay,specifier: "%.1f") m/s")
                        } else if option == .uvIndex {
                            Text("\(Int(valueYesterDay))")
                        } else if option == .humidity {
                            Text("\(valueYesterDay,specifier: "%.1f") %")
                        } else if option == .temperature {
                            Text("\(valueYesterDay,specifier: "%.1f") ºC")
                        } else {
                            Text("\(valueYesterDay, specifier: "%.1f")")
                        }
                    }
                }
            }
        }
        .padding(5)
    }
}

