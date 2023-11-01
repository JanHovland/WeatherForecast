//
//  AirQualityView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct AirQualityView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var minValue : CGFloat = 0.0
    @State private var maxValue : CGFloat = 5.0
    @State private var gradient = Gradient(colors: [.green, .yellow, .orange, .red, .purple])
    
    @State private var isModal: Bool = false
    
//    @State private var image: String
//    
//    @State private var so2 = Double()
//    @State private var no2 = Double()
//    @State private var pm10 = Double()
//    @State private var pm2_5 = Double()
//    @State private var o3 = Double()
//    @State private var co = Double()
    
    var body: some View {
        VStack {
            if currentWeather.dt != 0 {
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
                .padding(.top, 40)
                .padding(.leading, UIDevice.isIpad ? -180 : -180)
                if UIDevice.isiPhone {
                    ZStack {
                       Spacer()
                        HStack {
                            Spacer()
                            Button("Information") {
                                self.isModal = true
                            }
                            .sheet(isPresented: $isModal, content: {
                                AirQualityViewInformation(image: currentWeather.image,
                                                          so2: currentWeather.co,
                                                          no2: currentWeather.no2,
                                                          pm10: currentWeather.pm10,
                                                          pm2_5: currentWeather.pm2_5,
                                                          o3: currentWeather.o3,
                                                          co: currentWeather.co)
                            })
                        }
                        .padding(.trailing, 10)
                    }
                }
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
                    let v = String(localized: "Sulphur dioxide ")
                    Text("\(v)(SO\u{2082}) : \(Int(currentWeather.so2)) μg/m\u{00B3}")
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
                    let v = String(localized: "Nitrogen dioxide ")
                    Text("\(v)(NO\u{2082}) : \(Int(currentWeather.no2)) μg/m\u{00B3}")
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
                ///
                /// Viser verdien av particulates (PM10):
                ///
                HStack {
                    let v = String(localized: "Particulates ") // (PM10): ")
                    Text("\(v)(PM\u{2081}\u{2080}) : \(Int(currentWeather.pm10)) μg/m\u{00B3}")
                    Spacer()
                }
                .font(.footnote)
                .padding(.top, -25)
                .padding(.leading, 5)
                ///
                /// Viser vivået av particulates (PM10):
                ///
                ZStack {
                    HStack {
                        if currentWeather.pm10 < 20.00 {
                            Spacer()
                            Text("Good")
                                .foregroundColor(.green)
                        } else if currentWeather.pm10 > 20.00,
                                  currentWeather.pm10 <= 50.00 {
                            Spacer()
                            Text("Fair")
                                .foregroundColor(.yellow)
                        } else if currentWeather.pm10 >  50.00,
                                  currentWeather.pm10 <= 100.00 {
                            Spacer()
                            Text("Moderate")
                                .foregroundColor(.orange)
                        } else if currentWeather.pm10 >  100.00,
                                  currentWeather.pm10 <= 200.00 {
                            Spacer()
                            Text("Poor")
                                .foregroundColor(.red)
                        } else if currentWeather.pm10 >= 200.00 {
                            Spacer()
                            Text("Very poor")
                                .foregroundColor(.purple)
                        }
                    }
                }
                .font(.footnote)
                .offset(x: UIDevice.isIpad ? -5  : -5,
                        y: UIDevice.isIpad ? -25 : -25)
                ///
                /// Viser verdien av Viser verdien av particulates (PM2.5):
                ///
                HStack {
                    let v = String(localized: "Particulates ")
                    Text("\(v)(PM\u{2082}\u{208B}\u{2085}) : \(Int(currentWeather.pm2_5)) μg/m\u{00B3}")
                    Spacer()
                }
                .font(.footnote)
                .padding(.top, -30)
                .padding(.leading, 5)
                ///
                /// Viser vivået av  particulates (PM2.5):
                ///
                ZStack {
                    HStack {
                        if currentWeather.pm2_5 < 10.00 {
                            Spacer()
                            Text("Good")
                                .foregroundColor(.green)
                        } else if currentWeather.pm2_5 > 10.00,
                                  currentWeather.pm2_5 <= 25.00 {
                            Spacer()
                            Text("Fair")
                                .foregroundColor(.yellow)
                        } else if currentWeather.pm2_5 >  25.00,
                                  currentWeather.pm2_5 <= 50.00 {
                            Spacer()
                            Text("Moderate")
                                .foregroundColor(.orange)
                        } else if currentWeather.pm2_5 >  50.00,
                                  currentWeather.pm2_5 <= 75.00 {
                            Spacer()
                            Text("Poor")
                                .foregroundColor(.red)
                        } else if currentWeather.pm2_5 >= 75.00 {
                            Spacer()
                            Text("Very poor")
                                .foregroundColor(.purple)
                        }
                    }
                }
                .font(.footnote)
                .offset(x: UIDevice.isIpad ? -5  : -5,
                        y: UIDevice.isIpad ? -30 : -30)
                ///
                /// Viser verdien av Viser verdien av Ozone (O3):
                ///
                HStack {
                    let v = String(localized: "Ozone ")
                    if currentWeather.o3 < 1.00 {
                        Text("\(v)(O\u{2083}) : \(String(format: "%.2f", currentWeather.o3)) μg/m\u{00B3}")
                    } else {
                        Text("\(v)(O\u{2083}) : \(Int(currentWeather.o3)) μg/m\u{00B3}")
                    }
                    Spacer()
                }
                .font(.footnote)
                .padding(.top, -35)
                .padding(.leading, 5)
                ///
                /// Viser vivået av  particulates (PM2.5):
                ///
                ZStack {
                    HStack {
                        if currentWeather.o3 < 60.00 {
                            Spacer()
                            Text("Good")
                                .foregroundColor(.green)
                        } else if currentWeather.o3 > 60.00,
                                  currentWeather.o3 <= 100.00 {
                            Spacer()
                            Text("Fair")
                                .foregroundColor(.yellow)
                        } else if currentWeather.o3 >  100.00,
                                  currentWeather.o3 <= 140.00 {
                            Spacer()
                            Text("Moderate")
                                .foregroundColor(.orange)
                        } else if currentWeather.o3 >  140.00,
                                  currentWeather.o3 <= 180.00 {
                            Spacer()
                            Text("Poor")
                                .foregroundColor(.red)
                        } else if currentWeather.o3 >= 180.00 {
                            Spacer()
                            Text("Very poor")
                                .foregroundColor(.purple)
                        }
                    }
                }
                .font(.footnote)
                .offset(x: UIDevice.isIpad ? -5  : -5,
                        y: UIDevice.isIpad ? -35 : -35)
                ///
                /// Viser verdien av Carbon monoxide (CO):
                ///
                HStack {
                    let v = String(localized: "Carbon monoxide (CO): ")
                    Text("\(v)\(Int(currentWeather.co)) μg/m\u{00B3}")
                    Spacer()
                }
                .font(.footnote)
                .padding(.top, -40)
                .padding(.leading, 5)
                ///
                /// Viser vivået av Carbon monoxide (CO):
                ///
                ZStack {
                    HStack {
                        if currentWeather.co < 4400.00 {
                            Spacer()
                            Text("Good")
                                .foregroundColor(.green)
                        } else if currentWeather.co > 4400.00,
                                  currentWeather.co <= 9400.00 {
                            Spacer()
                            Text("Fair")
                                .foregroundColor(.yellow)
                        } else if currentWeather.co >  9400.00,
                                  currentWeather.co <= 12400.00 {
                            Spacer()
                            Text("Moderate")
                                .foregroundColor(.orange)
                        } else if currentWeather.co >  12400.00,
                                  currentWeather.co <= 15400.00 {
                            Spacer()
                            Text("Poor")
                                .foregroundColor(.red)
                        } else if currentWeather.co >= 15400.00 {
                            Spacer()
                            Text("Very poor")
                                .foregroundColor(.purple)
                        }
                    }
                }
                .font(.footnote)
                .offset(x: UIDevice.isIpad ? -5  : -5,
                        y: UIDevice.isIpad ? -40 : -40)
            } else {
                VStack {
                    ZStack {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .renderingMode(.original)
                                .font(Font.headline.weight(.regular))
                            Text("AIR QUALITY")
                                .font(.system(size: 15, weight: .bold))
                                .opacity(0.50)
                            Spacer()
                        }
                    }
                    .offset(x: UIDevice.isIpad ? 0 : 0,
                            y: UIDevice.isIpad ? -70 : -70)
                    Text("No available data for air quality in \(weatherInfo.placeName) \(weatherInfo.countryName)")
                }
            }
        }
        .frame(width: UIDevice.isIpad ? 358 : 358,
               height: UIDevice.isIpad ? 200 : 230)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}


