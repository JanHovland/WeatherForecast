    //
    //  MoonInformation.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 29/09/2025.
    //

import SwiftUI

struct MoonInformation: View {
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            ZStack {
                    //                HStack {
                    //                    Image(systemName: image)
                    //                        .symbolRenderingMode(.multicolor)
                    //                        .font(Font.headline.weight(.regular))
                    //                    Spacer()
                    //                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 20)
                        })
                    }
                    .padding(.top, 20)
                }
            }
            
            Text(currentWeather.moonEmoji)
                .font(.system(size: 130))
            
            Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")))
            
            VStack {
                HStack(spacing: UIDevice.isIpad ? 20 : 0) {
                    HStack {
                        Spacer()
                        Text("Illumination").textCase(.uppercase)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("MoonRise").textCase(.uppercase)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("MoonSet").textCase(.uppercase)
                        Spacer()
                    }
                }
                .font(.caption)
                
                HStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Text(currentWeather.moonIllumination)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(currentWeather.moonrise)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(currentWeather.moonset)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, UIDevice.isIpad ? 80 : 0)
            .padding(.top,10)
            Spacer()
        }
    }
}

