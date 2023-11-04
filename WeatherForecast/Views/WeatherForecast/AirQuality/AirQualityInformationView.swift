//
//  AirQualityInformationView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/10/2023.
//

import SwiftUI

struct AirQualityInformationView: View {
    
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
    @State private var pm10Index: Int = 0
    @State private var pm2_5Index: Int = 0
    @State private var o3Index: Int = 0
    @State private var coIndex: Int = 0

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
                /// Viser  icon luftkvalitet
                ///
                HStack {
                    Spacer()
                    Image(systemName: image)
                        .renderingMode(.original)
                        .font(Font.largeTitle.weight(.regular))
                    Spacer()
                }
                .padding(10)
            }
            List {
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
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(so2AqLimit, id: \.index) { aq in
                    if aq.index == so2Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: so2,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: so2Index, index: aq.index))
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
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(no2AqLimit, id: \.index) { aq in
                    if aq.index == no2Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: no2,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: no2Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  PM10:
                ///
                HStack {
                    Spacer()
                    Text("\(aqPM) \(PM10)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(pm10AqLimit, id: \.index) { aq in
                    if aq.index == pm10Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: pm10,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: pm10Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  PM2.5:
                ///
                HStack {
                    Spacer()
                    Text("\(aqPM) \(PM2_5)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(pm2_5AqLimit, id: \.index) { aq in
                    if aq.index == pm10Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: pm2_5,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: pm2_5Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  O3:
                ///
                HStack {
                    Spacer()
                    Text("\(aqO3) \(O3)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(o3AqLimit, id: \.index) { aq in
                    if aq.index == o3Index {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: o3,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: o3Index, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                ///
                /// Viser  CO:
                ///
                HStack {
                    Spacer()
                    Text("\(aqCO)")
                        .font(.system(.headline).italic())
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 5)
                ///
                /// Overskrift:
                ///
                AirQualityHeadlineView()
                .padding(.horizontal, 10)
                
                ForEach(coAqLimit, id: \.index) { aq in
                    if aq.index == coIndex {
                        AirQualityPollutionView(designation: aq.designation,
                                                index: aq.index,
                                                value: co,
                                                range: aq.range)
                        .modifier(AirQualityViewModifier(aqIndex: coIndex, index: aq.index))
                        .padding(.horizontal, 10)
                   }
                }
                Spacer()
            }
            .offset(y : UIDevice.isIpad ? 0 : -25)
            .listStyle(.sidebar)
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
                so2Index = 4          
            }
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
                no2Index = 4
            }
            else if currentWeather.no2 >= 200.00 {
                no2Index = 5
            }
            /// Finner pm10Index
            ///
            if currentWeather.pm10 < 20.00 {
                pm10Index = 1
            } else if currentWeather.pm10 >  20.00,
                      currentWeather.pm10 <= 50.00 {
                pm10Index = 2
            } else if currentWeather.pm10 >  50.00,
                      currentWeather.pm10 <= 100.00 {
                pm10Index = 3
            } else if currentWeather.pm10 >  100.00,
                      currentWeather.pm10 <= 200.00 {
                pm10Index = 4
            }
            else if currentWeather.pm10 >= 200.00 {
                pm10Index = 5
            }
            /// Finner pm2_5Index
            ///
            if currentWeather.pm2_5 < 10.00 {
                pm2_5Index = 1
            } else if currentWeather.pm2_5 >  10.00,
                      currentWeather.pm2_5 <= 25.00 {
                pm2_5Index = 2
            } else if currentWeather.pm2_5 >  25.00,
                      currentWeather.pm2_5 <= 50.00 {
                pm2_5Index = 3
            } else if currentWeather.pm2_5 >  50.00,
                      currentWeather.pm2_5 <= 75.00 {
                pm2_5Index = 4
            }
            else if currentWeather.pm2_5 >= 75.00 {
                pm2_5Index = 5
            }
            /// Finner o3Index
            ///
            if currentWeather.o3 < 60.00 {
                o3Index = 1
            } else if currentWeather.o3 >  60.00,
                      currentWeather.o3 <= 100.00 {
                o3Index = 2
            } else if currentWeather.o3 >  100.00,
                      currentWeather.o3 <= 140.00 {
                o3Index = 3
            } else if currentWeather.o3 >  140.00,
                      currentWeather.o3 <= 180.00 {
                o3Index = 4           
            }
            else if currentWeather.o3 >= 180.00 {
                o3Index = 5
            }
            /// Finner co3Index
            ///
            if currentWeather.co < 4400.00 {
                coIndex = 1
            } else if currentWeather.co >  4400.00,
                      currentWeather.co <= 9400.00 {
                coIndex = 2
            } else if currentWeather.co >  9400.00,
                      currentWeather.co <= 12400.00 {
                coIndex = 3
            } else if currentWeather.co >  12400.00,
                      currentWeather.co <= 15400.00 {
                coIndex = 4
            }
            else if currentWeather.co >= 15400.00 {
                coIndex = 5
            }
        }
    }
}
