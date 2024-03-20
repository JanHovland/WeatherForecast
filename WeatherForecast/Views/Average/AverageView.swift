//
//  AverageView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI

struct AverageView : View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selection1: Bool = true
    @State private var selection2: Bool = false
    
    @State private var isTemperature: Bool = false
    @State private var isPrecification: Bool = false
    
    
    let color1 = Color(red: 127 / 255, green: 128 / 255, blue: 132 / 255).opacity(0.25)
    let color2 = Color(red: 71 / 255, green: 75 / 255, blue: 76 / 255).opacity(0.75)
    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("AVERAGES")
                Spacer()
            }
            .padding(20)
            .overlay (
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
                }
            )
            HStack (spacing: 60) {
                Button(action: {
                    selection1 = true
                    selection2 = false
                    isTemperature = true
                    isPrecification = false
                }) {
                    Text(String(localized: "Temperature"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 60)
                        .background(selection1 == false ? color1 : color2)
                        .foregroundColor(.white)
                        .cornerRadius(7.5)
                }
                Button(action: {
                    selection1 = false
                    selection2 = true
                    isTemperature = false
                    isPrecification = true
                }) {
                    Text(String(localized: "Precification"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 60)
                        .background(selection2 == false ? color1 : color2)
                        .foregroundColor(.white)
                        .cornerRadius(7.5)
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isTemperature, content: {
            AverageTemperatureDetailView()
        })
        .sheet(isPresented: $isPrecification, content: {
            AveragePrecificationDetailView()
        })
    }
}
