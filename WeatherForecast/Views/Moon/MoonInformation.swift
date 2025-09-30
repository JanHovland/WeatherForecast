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
                            .padding(.top, 20)
                    })
                }
            }
        }
        VStack {
                Text(currentWeather.moonEmoji)
                    .font(.system(size: 130))
                    .padding(.top, -50)
                Text(String(format: NSLocalizedString(currentWeather.moonMajorPhase, comment: "")))
                    .font(.title2).bold()
                Text(FormatDateToString(date: .now, format: "EEEE d. MMMM yyyy HH:mm", offsetSec: weatherInfo.offsetSec).firstUppercased)
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
            ScrollView {
                    ///
                    /// Calendar
                    ///
                MoonPhaseCalendar()
                
                VStack(alignment: .leading) {
                    Text("About illumination")
                    
                    Text("dfghjkløjhgvvbhjklølkjhnvbh")
                    
                    Text("About Moon Distance")
                    
                    Text("dfghjkløæølkjhcvbhnjmk,l.økjhnbgvfhjklølkjhn")
                }
                .padding(20)
            }
        }
        // .padding(.horizontal,30)
        .scrollIndicators(.hidden)
        Spacer()
    }
}
