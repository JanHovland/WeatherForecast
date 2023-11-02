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
    let aqCO: String = String(localized: "Carbon monoxide CO")

    @Environment(\.dismiss) var dismiss
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(CurrentWeather.self) private var currentWeather
    
    @State private var so2Index: Int = 0
    
    @State private var so2AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, value: "0:20"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, value: "20:80"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, value: "80:250"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, value: "250:350"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, value: "⩾350")]
                       
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
            VStack {
                ///
                /// Viser sted og land:
                ///
                HStack {
                    Spacer()
                    Text("\(weatherInfo.placeName) \(weatherInfo.countryName)")
                    Spacer()
                }
                ///
                /// Viser grenseverdiene for SO2:
                ///
                HStack {
                    Spacer()
                    Text("\(aqSO2) \(SO2)")
                        .font(.system(.headline, design: .monospaced).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                HStack {
                    HStack {
                        Text("Designation")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Index")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Pollutant")
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                ZStack {
                    List (so2AqLimit) { aq in
                        HStack {
                            HStack {
                                Text(aq.designation)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(aq.index)")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(aq.value)")
                            }
                        }
                        ///
                        /// Fargen il følge index:
                        ///
                        .modifier(AirQualityViewModifier(so2Index: so2Index, index: aq.index))
                    }
                    .listStyle(.inset)
                }
                .offset(y : UIDevice.isIpad ? 0 : -10)
                ZStack {
                    List (so2AqLimit) { aq in
                        HStack {
                            HStack {
                                Text(aq.designation)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(aq.index)")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(aq.value)")
                            }
                        }
                        ///
                        /// Fargen il følge index:
                        ///
                        .modifier(AirQualityViewModifier(so2Index: so2Index, index: aq.index))
                    }
                    .listStyle(.inset)
                }
                .offset(y : UIDevice.isIpad ? 0 : -10)
                Spacer()
            }
            .offset(y : UIDevice.isIpad ? 0 : 20)
        }
        .task {
            ///
            /// Finner so2Index
            ///
            if currentWeather.so2 < 20.00 {
                so2Index = 1
            } else if currentWeather.so2 >  20.00,
                      currentWeather.so2 <= 80.00 {
                so2Index = 2
            } else if currentWeather.so2 >  80.00,
                      currentWeather.so2 <= 250.00 {
                so2Index = 3
            } else if currentWeather.so2 >  250.00,
                      currentWeather.so2 <= 350.00 {
                so2Index = 4            }
            else if currentWeather.so2 >= 350.00 {
                so2Index = 5
            }
        }    
    }
}
