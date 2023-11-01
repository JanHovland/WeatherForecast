//
//  AirQualityViewInformation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI

struct AirQualityViewInformation: View {
    
    let image: String
    let so2: Double
    let no2: Double
    let pm10: Double
    let pm2_5: Double
    let o3: Double
    let co: Double
    
    @Environment(\.dismiss) var dismiss
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: image)
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.title2.weight(.thin))
                                .foregroundColor(.primary)
                        })
                    }
                }
            }
            
            Text("AirQualityViewInformation")
                .padding(.top, -27.5)
            
            HStack {
                Spacer()
                Text("\(weatherInfo.placeName) \(weatherInfo.countryName)")
                Spacer()
            }

            Text("o3 = \(String(format: "%.2f", o3))")
            
            Spacer()
        }
    }
}
