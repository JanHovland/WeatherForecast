//
//  MoonView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

///
///*  Viser månefasene pr. år/måned:
/// https://stardate.org/nightsky/moon
///

struct MoonView: View {
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            HStack {
                ///
                /// Viser overskriften for fluftkvaliteten:
                ///
                HStack {
                    Image(systemName: "moon")
                        .symbolRenderingMode(.multicolor)
                        .font(Font.headline.weight(.regular))
                    Text("MOON")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                }
                ///
                /// Viser måne fasen
                ///
                HStack {
                    Spacer()
                    Text(currentWeather.moonPhase.uppercased())
                        .font(.system(size: 15, weight: .bold))
                }
            }
            .opacity(0.50)
            .padding(.top, 10)
            ///
            /// Viser selve månen:
            ///
            let (image, daysToFullMoon) = FindMoonPhaseImage(moonPhase: currentWeather.moonPhase,
                                                             moonIllumination: currentWeather.moonIllumination)

            Image(image)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .symbolRenderingMode(.multicolor)
            ///
            /// Viser styrken på lyset fra månen:
            ///
            HStack {
                HStack {
                    Text("Illumination")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(currentWeather.moonIllumination) %")
                }
            }
            ///
            /// Måneoppgang:
            ///
            HStack {
                HStack {
                   Text("MoonRise")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(FindTimeFromAmPm(time: currentWeather.moonrise))
                }
            }
            ///
            /// Månenedgang:
            ///
            HStack {
                HStack {
                   Text("MoonSet")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(FindTimeFromAmPm(time: currentWeather.moonset))
                }
            }
            ///
            /// Dager til neste full måne:
            ///
            HStack {
                HStack {
                   Text("Next full moon")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(daysToFullMoon) d")
                }
            }
            Spacer()
        }
        .frame(width: UIDevice.isIpad ? 358 : 358,
               height: UIDevice.isIpad ? 280 : 280)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
