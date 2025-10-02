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
                    
                    Text(currentWeather.moonPhase)
                    
                    
                    
                        ///
                        /// Bruker NSLocalizedString ved kall til en variabel
                        ///
//                    Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")).uppercased())
//                        .font(.system(size: screenSize.screenWidth == 368 ? 14.5 : 15, weight: .bold))
//                    Text(String(format: NSLocalizedString(currentWeather.moonMajorPhase, comment: "")).uppercased())
//                        .font(.system(size: screenSize.screenWidth == 368 ? 14.5 : 15, weight: .bold))
 }
            }
            .opacity(0.50)
            .padding(.top, 20)
                ///
                /// Viser selve månen som en emoji:
                ///
            Text(currentWeather.moonEmoji)
                .font(.system(size: 70))
            
                ///
                /// phase
                ///
                HStack {
                    HStack {
                        Text("Phase")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(currentWeather.phase)")
                    }
                }
                
                ///
                /// majorPhase
                ///
                HStack {
                    HStack {
                        Text("MajorPhase")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(currentWeather.moonMajorPhase)
//                        Text(String(format: NSLocalizedString(currentWeather.moonMajorPhase, comment: "")))
                            
                    }
                }
            
                ///
                /// stage
                ///
                HStack {
                    HStack {
                        Text("Stage")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(currentWeather.stage)")
                    }
                }
                
                ///
                /// moonSign
                ///
                HStack {
                    HStack {
                        Text("MoonSign")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(currentWeather.moonSign)
                    }
                }
                

            
            
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
