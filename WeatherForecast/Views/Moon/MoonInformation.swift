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
                HStack {C
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                                 
                        })
                    }
                }
            }
            VStack {
                Text(currentWeather.moonEmoji)
                    .font(.system(size: 130))
                Text(String(format: NSLocalizedString(currentWeather.moonMajorPhase, comment: "")))
                    .font(.title2).bold()
                Text(FormatDateToString(date: .now, format: "EEEE d. MMMM yyyy HH:mm", offsetSec: weatherInfo.offsetSec).firstUppercased)
            }
            .offset(x:0, y:-40)
            VStack {
                HStack(spacing: 40) {
                    Text("Illumination")
                    Text("MoonRise")
                    Text("MoonSet")
                }
                HStack(spacing: 100) {
                    Text(currentWeather.moonIllumination)
                    Text(currentWeather.moonrise)
                    Text(currentWeather.moonset)
                }
            }
            .offset(x:0, y:-20)
            ScrollView {
                    ///
                    /// Calendar
                    ///
                MoonPhaseCalendar()
            }
            .offset(x:0, y:-30)
        }
        .padding(.horizontal,30)
        .scrollIndicators(.hidden)
        Spacer()
    }
}



