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
    
    /// https://www.compart.com/en/unicode/U+00B3
    /// https://www.compart.com/en/unicode/block/U+0080
    /// https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts#Superscripts_and_subscripts_block
    /// \u{00B3} = ³
    /// \u{2082} =
    
    var descriptionSO2 =
"""
Sulphur dioxide (SO\u{2082})
Qualitative name    Index    Pollutant μg/m\u{00B3}
Good                 1       0:20
Fair                 2       0:80
Moderate             3       80:250
Poor                 4       250:350
Very Poor            5       ⩾350
"""
    
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

            Text("o\u{2082} = \(String(format: "%.2f", o3))")
            
            
            Text(descriptionSO2)
                .font(.system(.footnote, design: .monospaced).italic())
            
            Text("Pm\u{2081}\u{2080}")
            Text("Pm\u{2082}\u{208B}\u{2085}")

            
            

            Spacer()
        }
    }
}
