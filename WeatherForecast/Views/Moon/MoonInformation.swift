    //
    //  MoonInformation.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 29/09/2025.
    //

import SwiftUI

struct MoonInformation: View {
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 20)
                        })
                    }
                    // .padding(.top, 20)
                }
            }
            
            Text(currentWeather.moonEmoji)
                .font(.system(size: 130))
            
//            Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")))
//                .font(.title).bold()
//                .padding(.bottom, 20)
            
            Text(String(format: NSLocalizedString(currentWeather.moonMajorPhase, comment: "")))
                .font(.title).bold()
 //               .padding(.bottom, 20)
            
            Text(FormatDateToString(date: .now, format: "EEEE d. MMMM yyyy HH:mm", offsetSec: weatherInfo.offsetSec).firstUppercased)
            
            
            ScrollView {
                    ///
                    /// Illumination
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
                    /// MoonRise
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
                    /// MoonSet
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
                    /// Next full moon
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
                    /// Distance
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
                    ///
                    /// Calendar
                    ///
                MoonPhaseCalendar()
            }
        }
        .padding(.horizontal,30)
        .scrollIndicators(.hidden)
        Spacer()
    }
}



