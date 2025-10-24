//
//  MoonView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

///
/// Viser månefasene pr. år/måned:
/// https://stardate.org/nightsky/moon
///

struct MoonView: View {
    @Environment(CurrentWeather.self) private var currentWeather
    
    @State private var showNewView = false
    
    var body: some View {
        VStack {
            HStack {
                ///
                /// Viser overskriften for månen:
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
                    // Text(currentWeather.moonPhase)
                    ///
                    /// Bruker NSLocalizedString ved kall til en variabel
                    ///
                    Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")).uppercased())
                        .font(.system(size: UIDevice.isIpad ? 15 : 14, weight: .bold))
                }
            }
            .opacity(0.50)
            .padding(.top, 20)
            ///
            /// Viser selve månen som en emoji:
            ///
            Text(currentWeather.moonEmoji)
                .font(.system(size: 30))
            MoonInfo(heading: "Phase", value: "\(currentWeather.phase)")
            MoonInfo(heading: "MajorPhase", value: currentWeather.moonMajorPhase)
            
            if currentWeather.moonSign == String(localized: "Leo") {
                MoonInfo(heading: "MoonSign", value: "♌️ " + currentWeather.moonSign)
            } else if currentWeather.moonSign == String(localized: "Virgo") {
                MoonInfo(heading: "MoonSign", value: "♍️ " + currentWeather.moonSign)
            } else if currentWeather.moonSign == String(localized: "Libra") {
                MoonInfo(heading: "MoonSign", value: "♎️ " + currentWeather.moonSign)
            } else if currentWeather.moonSign == String(localized: "Scorpio") {
                MoonInfo(heading: "MoonSign", value: "♏️ " + currentWeather.moonSign)}
            else if currentWeather.moonSign == String(localized: "Sagittarius") {
                MoonInfo(heading: "MoonSign", value: "♐️ " + currentWeather.moonSign)
            } else {
                MoonInfo(heading: "MoonSign", value: currentWeather.moonSign)
            }
            
            if currentWeather.sunSign == String(localized: "Libra") {
                MoonInfo(heading: "SunSign", value: "♎️ " + currentWeather.sunSign)
            } else if currentWeather.sunSign == String(localized: "Scorpio") {
                MoonInfo(heading: "SunSign", value: "♏️ " + currentWeather.sunSign)
            } else {
                MoonInfo(heading: "SunSign", value: currentWeather.sunSign)
            }
              
            MoonInfo(heading: "Illumination", value: currentWeather.moonIllumination)
            MoonInfo(heading: "MoonRise", value: currentWeather.moonrise)
            MoonInfo(heading: "MoonSet", value: currentWeather.moonset)
            MoonInfo(heading: "Next full moon", value: "\(currentWeather.daysToFullMoon) d")
            MoonInfo(heading: "About Moon Distance", value: "\(currentWeather.distanceToMoon) km")
            VStack {
                MoonInfo(heading: "Neste fullmåne", value: currentWeather.fullMoon.firstUppercased)
                MoonInfo(heading: "Neste nymåne", value: currentWeather.newMoon.firstUppercased)
            }
            .font(UIDevice.isIpad ? .body : .caption2)
         }
        .padding(20)
        .offset(x: 0, y: -15)
        .contentShape(Rectangle())
        .onTapGesture {
            showNewView.toggle()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 320)  
        .sheet(isPresented: $showNewView) {
            MoonInformation()
        }
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
