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
            
//            .opacity(0.50)
//            .padding(.leading, -40)
            
//            Text(currentWeather.moonPhase)
            Text(FindTimeFromAmPm(time: currentWeather.moonrise))
            Text(FindTimeFromAmPm(time: currentWeather.moonset))
            Text("\(currentWeather.moonIllumination)")
            Text("Moon: \(currentWeather.isMoonUp)")
            Text("Sun: \(currentWeather.isSunUp)")

            
            Spacer()
        }
        .frame(width: UIDevice.isIpad ? 358 : 358,
               height: UIDevice.isIpad ? 200 : 200)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
