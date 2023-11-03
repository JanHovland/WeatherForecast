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
    @State private var no2Index: Int = 0

    @State private var so2AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:20"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "20:80"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "80:250"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "250:350"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾350")]
                       
    @State private var no2AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:40"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "40:70"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "70:150"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "150:200"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾200")]
                       
    @State private var pm10AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:20"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "20:50"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "50:100"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "100:200"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾200")]
                       
    @State private var pm2_5AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:10"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "10:25"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "25:50"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "50:75"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾75")]
                       
    @State private var o3AqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:60"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "60:100"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "100:140"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "140:180"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾180")]
                       
    @State private var coAqLimit = [
                AQLimit(id: UUID(), designation: String(localized: "Good"), index: 1, range: "0:4400"),
                AQLimit(id: UUID(), designation: String(localized: "Fair"), index: 2, range: "4400:9400"),
                AQLimit(id: UUID(), designation: String(localized: "Moderate"), index: 3, range: "9400:12400"),
                AQLimit(id: UUID(), designation: String(localized: "Poor"), index: 4, range: "12400:15400"),
                AQLimit(id: UUID(), designation: String(localized: "Very poor"), index: 5, range: "⩾15400")]
                       
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
                        .font(.system(.title2).italic())
                    Spacer()
                }
                ///
                /// Viser  SO2:
                ///
                HStack {
                    Spacer()
                    Text("\(aqSO2) \(SO2)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                HeadView()
                .padding(.horizontal, 10)
                
                ForEach(so2AqLimit, id: \.index) { aq in
                    if aq.index == so2Index {
                        PollutionView(designation: aq.designation,
                                      index: aq.index,
                                      value: so2,
                                      range: aq.range)
                        .modifier(AirQualityViewModifier(so2Index: so2Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  NO2:
                ///
                HStack {
                    Spacer()
                    Text("\(aqNO2) \(NO2)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                HeadView()
                .padding(.horizontal, 10)
                
                ForEach(no2AqLimit, id: \.index) { aq in
                    if aq.index == no2Index {
                        PollutionView(designation: aq.designation,
                                      index: aq.index,
                                      value: no2,
                                      range: aq.range)
                        .modifier(AirQualityViewModifier(so2Index: so2Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }

                
                
                
//                .offset(y : UIDevice.isIpad ? 0 : -10)
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
            }            ///
            /// Finner no2Index
            ///
            if currentWeather.no2 < 40.00 {
                no2Index = 1
            } else if currentWeather.no2 >  40.00,
                      currentWeather.no2 <= 70.00 {
                no2Index = 2
            } else if currentWeather.no2 >  70.00,
                      currentWeather.no2 <= 150.00 {
                no2Index = 3
            } else if currentWeather.no2 >  150.00,
                      currentWeather.no2 <= 200.00 {
                no2Index = 4            }
            else if currentWeather.no2 >= 200.00 {
                no2Index = 5
            }
        }
    }
}

struct PollutionView : View {
    let designation: String
    let index: Int
    let value: Double
    let range: String
    
    var body: some View {
        
        HStack {
            HStack {
                Text(designation)
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(index)")
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(Int(value))")
                Spacer()
            }
            HStack {
                Spacer()
                Text(range)
            }
        }
    }
}

struct HeadView: View {
    var body: some View {
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
            Text("Value")
            Spacer()
        }
        HStack {
            Spacer()
            Text("Range")
        }
    }
}}
