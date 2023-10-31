//
//  AirQualityViewInformation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI

struct AirQualityViewInformation: View {
    
    @Binding var image: String
    
    @Environment(\.dismiss) var dismiss
    @Environment(WeatherInfo.self) private var weatherInfo
    
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
            
            Text("sdfvgbhnjmk,l.")
            
            Spacer()
        }
    }
}
