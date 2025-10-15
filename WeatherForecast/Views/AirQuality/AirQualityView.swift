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
    @State private var so2Index: Int = 0

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
                            .symbolRenderingMode(.multicolor)
                            .font(Font.headline.weight(.regular))
                    } else if currentWeather.aqi == 2 {
                        Image(systemName: "aqi.medium")
                            .symbolRenderingMode(.multicolor)
                            .font(Font.headline.weight(.regular))
                    } else if currentWeather.aqi == 3 {
                        Image(systemName: "aqi.medium")
                            .symbolRenderingMode(.multicolor)
                            .font(Font.headline.weight(.regular))
                    } else if currentWeather.aqi == 4 {
                        Image(systemName: "aqi.high")
                            .symbolRenderingMode(.multicolor)
                            .font(Font.headline.weight(.regular))
                    } else if currentWeather.aqi == 5 {
                        Image(systemName: "aqi.high")
                            .symbolRenderingMode(.multicolor)
                            .font(Font.headline.weight(.regular))
                    }
                    Text("AIR QUALITY")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                }
                .opacity(0.50)
                .padding(.top, UIDevice.isIpad ? 75 : 65)
                .frame(maxWidth: .infinity,
                       maxHeight: 290)
                .offset(y: -40)
                VStack {
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
                    .frame(width: 300, height: 2)
                    .gaugeStyle(.accessoryLinear)
                    .padding(.top, 10)
                    ///
                    /// Viser verdien av Sulphur dioxide (SO2):
                    ///
                    HStack {
                        let v = String(localized: "Sulphur dioxide")
                        Text("\(v) \(SO2) : \(Int(currentWeather.so2)) \(aqUnit)")
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -20 : -20)
                    ///
                    /// Viser verdien av Nitrogen dioxide:
                    ///
                    HStack {
                        let v = String(localized: "Nitrogen dioxide")
                        Text("\(v) \(NO2) : \(Int(currentWeather.no2)) \(aqUnit)")
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -20 : -20)
                    ///
                    /// Viser verdien av particulates (PM10):
                    ///
                    HStack {
                        let v = String(localized: "Particulates")
                        Text("\(v) \(PM10) : \(Int(currentWeather.pm10)) \(aqUnit)")
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -25 : -25)
                    ///
                    /// Viser verdien av Viser verdien av particulates (PM2.5):
                    ///
                    HStack {
                        let v = String(localized: "Particulates")
                        Text("\(v) \(PM2_5) : \(Int(currentWeather.pm2_5)) \(aqUnit)")
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -30 : -30)
                    ///
                    /// Viser verdien av Viser verdien av Ozone (O3):
                    ///
                    HStack {
                        let v = String(localized: "Ozone")
                        if currentWeather.o3 < 1.00 {
                            Text("\(v) \(O3) : \(String(format: "%.2f", currentWeather.o3)) \(aqUnit)")
                        } else {
                            Text("\(v) \(O3) : \(Int(currentWeather.o3)) \(aqUnit)")
                        }
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -35 : -35)
                    ///
                    /// Viser verdien av Carbon monoxide (CO):
                    ///
                    HStack {
                        let v = String(localized: "Carbon monoxide CO : ")
                        Text("\(v)\(Int(currentWeather.co)) \(aqUnit)")
                        Spacer()
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .padding(.top, -41)
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
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .offset(x: UIDevice.isIpad ? -5  : -5,
                            y: UIDevice.isIpad ? -41 : -41)
                    ///
                    /// Viser vedien for nh3
                    /// NH3: min value 0.1 - max value 200
                    ///
                    HStack {
                        HStack {
                            let v = String(localized: "Ammonia ")
                            Text("\(v)\(NH3) : \(Int(currentWeather.nh3)) \(aqUnit)")
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            let v = "Max : "
                            Text("\(v)200 \(aqUnit)")
                                .padding(.trailing, 5)
                                .foregroundColor(.red)
                       }
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .padding(.top, -47)
                    .padding(.leading, 5)
                    ///
                    /// Viser vedien for no
                    /// NO: min value 0.1 - max value 100
                    ///
                    HStack {
                        HStack {
                            let v = String(localized: "Nitrogen monoxide ")
                            Text("\(v)\("NO") : \(Int(currentWeather.no)) \(aqUnit)")
                            Spacer()
                        }
                    }
                    .font(UIDevice.isIpad ? .footnote : .caption)
                    .padding(.top, -37)
                    .padding(.leading, 5)
                    ZStack {
                        HStack {
                            Spacer()
                            let v = "Max : "
                            Text("\(v)100 \(aqUnit)")
                                .foregroundColor(.red)
                                .font(UIDevice.isIpad ? .footnote : .caption)
                        }
                    }
                    .offset(x: -5,
                            y: UIDevice.isIpad ? -38 : -38)
                }
                .offset(y: UIDevice.isIpad ? -30 : -40)
            } else {
                VStack {
                    ZStack {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .symbolRenderingMode(.multicolor)
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
        ///
        /// Ved contentShape() kan du trykke hvorsom helst på viewet
        ///
        .contentShape(Rectangle())
        .onTapGesture {
            isModal.toggle()
        }
        .sheet(isPresented: $isModal, content: {
            AirQualityInformationView(image: currentWeather.image,
                                      so2: currentWeather.so2,
                                      no2: currentWeather.no2,
                                      pm10: currentWeather.pm10,
                                      pm2_5: currentWeather.pm2_5,
                                      o3: currentWeather.o3,
                                      co: currentWeather.co)
        })
        .frame(maxWidth: .infinity,
               maxHeight: 290)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
