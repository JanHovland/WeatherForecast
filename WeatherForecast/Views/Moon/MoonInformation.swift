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
                .padding(.bottom, 10)
            Text(FormatDateToString(date: .now, format: "EEEE d. MMMM yyyy HH:mm", offsetSec: weatherInfo.offsetSec).firstUppercased)
                .padding(.bottom, 10)
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
                
                VStack() {
                    Text("About illumination")
                        .font(.system(.title2)).bold()
                        .padding(20)
                     
                    Text("Illumination refers to the percentage of the moon's Earth-facing surface that is lit up by the sun. A full moon is 100% lit up, and a new moon is 0% lit up. This percentage does not take into account whether the moon is risen or whether there are any clouds, so the number can be above zero even when you can't see the moon.")
                    
                    Text("About Moon Distance")
                        .font(.system(.title2)).bold()
                        .padding(20)
                        
                    Text("The moon has an elliptical orbit, which means its distance from the Earth changes throughout the month. The distance is measured from the core of the moon to the Earth's core and varies from approximately 356 500 km to 406 700 km.")
                }
                .padding(20)
            }
        }
        .scrollIndicators(.hidden)
        Spacer()
    }
}
