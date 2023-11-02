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
    let aqSO2: String = String(localized: "Sulphur dioxide")
    let aqNO2: String = String(localized: "Nitrogen dioxide")
    let aqPM: String = String(localized: "Particulates")
    let aqO3: String = String(localized: "Ozone")
    let aqCO: String = String(localized: "Carbon monoxide (CO)")

    @Environment(\.dismiss) var dismiss
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(CurrentWeather.self) private var currentWeather
    
    /// https://www.compart.com/en/unicode/U+00B3
    /// https://www.compart.com/en/unicode/block/U+0080
    /// https://en.wikipedia.org/wiki/Unicode_subscripts_and_superscripts#Superscripts_and_subscripts_block
    @State private var heading = String(localized: "Qualitative name    Index    Pollutant")
    
    var descriptionSO2 =
"""
Good                 1       0:20\n
Fair                 2       0:80\n
Moderate             3       80:250\n
Poor                 4       250:350\n
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
            
            Text("Detailed information on air quality")
                .padding(.top, -27.5)
            ///
            /// Viser sted og land:
            ///
            HStack {
                Spacer()
                Text("\(weatherInfo.placeName) \(weatherInfo.countryName)")
                Spacer()
            }
            .padding(.top, 10)
            ///
            /// Viser grenseverdiene for SO2:
            ///
            Text("\(aqSO2) (\(SO2)")
                .font(.system(.headline, design: .monospaced).italic())
                .padding(.top, 10)
            ///
            /// Overskrift:
            ///
            HStack {
                Text(heading)
                    .font(.system(.footnote, design: .monospaced).italic())
                Spacer()
            }
            Text(descriptionSO2)
                .font(.system(.footnote, design: .monospaced).italic())
 
            Spacer()
        }
    }
}
