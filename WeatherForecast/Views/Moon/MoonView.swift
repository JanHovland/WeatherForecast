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
    @Environment(ScreenSize.self) private var screenSize
    
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
                        .font(.system(size: screenSize.screenWidth == 368 ? 14.5 : 15, weight: .bold))
                    Spacer()
                }
                    ///
                    /// Viser måne fasen
                    ///
                HStack {
                    Spacer()
                        ///
                        /// Bruker NSLocalizedString ved kall til en variabel
                        ///
                    Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")).uppercased())
                        .font(.system(size: screenSize.screenWidth == 368 ? 14.5 : 15, weight: .bold))
                }
            }
            .opacity(0.50)
            .padding(.top, 20)
                ///
                /// Viser selve månen som en emoji:
                ///
            Text(currentWeather.moonEmoji)
                .font(.system(size: 130))
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
                    Text(currentWeather.moonIllumination)
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
                    Text(currentWeather.moonrise)
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
                    Text(currentWeather.moonset)
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
                    Text("\(currentWeather.daysToFullMoon) d")
                    
                }
            }
                ///
                /// Distanse til månen
                ///
            HStack {
                HStack {
                    Text("Distance")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(currentWeather.distanceToMoon) km")
                }
            }
        }
        .padding(20)
        .offset(x: 0, y: -15)
        .contentShape(Rectangle())
        .onTapGesture {
            print("onTapGesture")
            showNewView.toggle()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 320) // 290)
        .sheet(isPresented: $showNewView) {
            NewView()
        }
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}


struct NewView: View {
    @Environment(CurrentWeather.self) private var currentWeather
    var body: some View {
        VStack {
                // Color.green.opacity(0.3).ignoresSafeArea()
//            Color("Background#01")
//                .opacity(0.35)
//                .ignoresSafeArea()
                 
                
            Text("Moon details")
                .padding(10)
                .font(.largeTitle)
        }
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
     }
}

