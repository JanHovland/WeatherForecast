//
//  MoonView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct MoonView: View {
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            ///
            /// Viser overskriften for fluftkvaliteten:
            ///
            HStack {
                Image(systemName: "moon")
                    .renderingMode(.original)
                    .font(Font.headline.weight(.regular))
                Text("MOON")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            .padding(.top, -5)
            ///
            /// Viser måne fasen
            ///
            ZStack {
                HStack {
                    Spacer()
                    Text(currentWeather.moonPhase.uppercased())
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                }
            }
            .opacity(0.50)
            .offset(x: UIDevice.isIpad ? 85 : 85,
                    y: UIDevice.isIpad ? -20 : -20)
            ///
            /// Visernstyrken på lyset fra månen:
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
            .padding(.bottom, 5)
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
            .padding(.bottom, 5)
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
            .padding(.bottom, 5)
            ///
            /// Er månen synlig:
            ///
            HStack {
                HStack {
                   Text("Is the moon visible?")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(currentWeather.isMoonUp == 1 ? "Yes" : "No")
                }
            }
            .padding(.bottom, 5)
            ///
            /// Er solen synlig:
            ///
            HStack {
                HStack {
                   Text("Is the sun visible?")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(currentWeather.isSunUp == 1 ? "Yes" : "No")
                }
            }
            .padding(.bottom, 5)
            Spacer()
        }
        .frame(width: UIDevice.isIpad ? 358 : 358,
               height: UIDevice.isIpad ? 250 : 270)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
