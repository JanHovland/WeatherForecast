//
//  AirQualityView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct AirQualityView: View {
    @Environment(CurrentWeather.self) private var currentWeather

    @State private var minValue : CGFloat = 0.0
    @State private var maxValue : CGFloat = 5.0
    @State private var gradient = Gradient(colors: [.green, .yellow, .orange, .red, .purple])

    var body: some View {
        VStack {
            ///
            /// Viser overskriften for fluftkvaliteten:
            ///
            /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
            HStack {
                if currentWeather.aqi == 1 {
                    Image(systemName: "aqi.low")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                } else if currentWeather.aqi == 2 {
                    Image(systemName: "aqi.medium")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                } else if currentWeather.aqi == 3 {
                    Image(systemName: "aqi.medium")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                } else if currentWeather.aqi == 4 {
                    Image(systemName: "aqi.high")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                } else if currentWeather.aqi == 5 {
                    Image(systemName: "aqi.high")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                }
                Text("AIR QUALITY")
                    .font(.system(size: 15, weight: .bold))
            }
            .opacity(0.50)
            .padding(.leading, UIDevice.isIpad ? -180 : -180)
            ///
            /// Viser status for luftkvaliteten:
            ///
            HStack {
                /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
                if currentWeather.aqi == 1 {
                    Text("Good")
                        .foregroundColor(.green)
                } else if currentWeather.aqi == 2 {
                    Text("Fair")
                        .foregroundColor(.yellow)
                } else if currentWeather.aqi == 3 {
                    Text("Moderate")
                        .foregroundColor(.orange)
                } else if currentWeather.aqi == 4 {
                    Text("Poor")
                        .foregroundColor(.red)
                } else if currentWeather.aqi == 5 {
                    Text("Very poor")
                        .foregroundColor(.purple)
                }
                Spacer()
            }
            ///
            /// Viser progressbaren:
            ///
            ZStack {
                ///
                /// Markerer 1 som 0.50 osv.:
                ///
                Gauge(value: CGFloat(currentWeather.aqi) - 0.50, in: minValue...maxValue) {
                    Label("", systemImage: "")
                }
                .tint(gradient)
            }
            .frame(width: UIDevice.isIpad ? 350 : 350, height: 2)
            .gaugeStyle(.accessoryLinear)
            .padding(.top, 10)
            ///
            /// Viser verdien av Sulphur dioxide (SO2):
            ///
            HStack {
                Text("Sulphur dioxide (SO2): \(Int(currentWeather.so2)) μg/m3")
                Spacer()
            }
            .font(.footnote)
            .padding(.top, 10)
            .padding(.leading, 5)
            ///
            /// Viser vivået av Sulphur dioxide (SO2):
            ///
            ZStack {
                HStack {
                    if currentWeather.so2 < 20.00 {
                        Spacer()
                        Text("Good")
                            .foregroundColor(.green)
                    } else if currentWeather.so2 > 20.00,
                              currentWeather.so2 <= 80.00 {
                        Spacer()
                        Text("Fair")
                            .foregroundColor(.yellow)
                    } else if currentWeather.so2 >  80.00,
                              currentWeather.so2 <= 250.00 {
                        Spacer()
                        Text("Moderate")
                            .foregroundColor(.orange)
                    } else if currentWeather.so2 >  250.00,
                              currentWeather.so2 <= 350.00 {
                        Spacer()
                        Text("Poor")
                            .foregroundColor(.red)
                   } else if currentWeather.so2 >= 350.00 {
                        Spacer()
                        Text("Very poor")
                            .foregroundColor(.purple)
                    }
                }
            }
            .font(.footnote)
            .offset(x: UIDevice.isIpad ? -5  : -5,
                    y: UIDevice.isIpad ? -20 : -20)
            ///
            /// Viser verdien av Nitrogen dioxide:
            ///
            HStack {
                Text("Nitrogen dioxide (NO2): \(Int(currentWeather.no2)) μg/m3")
                Spacer()
            }
            .font(.footnote)
            .padding(.top, -20)
            .padding(.leading, 5)
            ///
            /// Viser vivået av Nitrogen dioxide:
            ///
            ZStack {
                HStack {
                    if currentWeather.no2 < 40.00 {
                        Spacer()
                        Text("Good")
                            .foregroundColor(.green)
                    } else if currentWeather.no2 > 40.00,
                              currentWeather.no2 <= 70.00 {
                        Spacer()
                        Text("Fair")
                            .foregroundColor(.yellow)
                    } else if currentWeather.no2 >  70.00,
                              currentWeather.no2 <= 150.00 {
                        Spacer()
                        Text("Moderate")
                            .foregroundColor(.orange)
                    } else if currentWeather.no2 >  150.00,
                              currentWeather.no2 <= 200.00 {
                        Spacer()
                        Text("Poor")
                            .foregroundColor(.red)
                   } else if currentWeather.no2 >= 200.00 {
                        Spacer()
                        Text("Very poor")
                            .foregroundColor(.purple)
                    }
                }
            }
            .font(.footnote)
            .offset(x: UIDevice.isIpad ? -5  : -5,
                    y: UIDevice.isIpad ? -20 : -20)
            Spacer()
        }
        .frame(width: 358, height: 175)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}


