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
            HStack {
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
            ///
            /// Viser selve månen:
            ///
            Image("moonVoksende månesigd 6")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 90)
                        .foregroundColor(.black.opacity(0.20))
                    
                )
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
            Spacer()
        }
        .frame(width: UIDevice.isIpad ? 358 : 358,
               height: UIDevice.isIpad ? 250 : 270)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
