//
//  AverageView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI

struct AverageView : View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var selection1: Bool = true
    @State private var selection2: Bool = false
    
    @State private var isTemperature: Bool = true
    @State private var isPrecification: Bool = false
    
    
    let color1 = Color(red: 58 / 255, green: 76 / 255, blue: 87 / 255).opacity(0.20)
    let color2 = Color(red: 113 / 255, green: 123 / 255, blue: 132 / 255).opacity(1.00)

    var body: some View {
        VStack {
            Text(weatherInfo.placeName + " " + weatherInfo.countryName)
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("AVERAGES")
                Spacer()
            }
            .opacity(0.50)
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
                        .padding(.horizontal, UIDevice.isIpad ? 60 : 30)
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
                        .padding(.horizontal, UIDevice.isIpad ? 60 : 30)
                        .background(selection2 == false ? color1 : color2)
                        .foregroundColor(.white)
                        .cornerRadius(7.5)
                }
            }
            if isTemperature == true {
                AverageTemperatureDetailView()
            }
            if isPrecification == true {
                AveragePrecipitationDetailView()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
    }
}
