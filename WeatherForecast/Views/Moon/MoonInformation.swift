    //
    //  MoonInformation.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 29/09/2025.
    //

import SwiftUI

/*
     🌙 How Moon Phases Work
    The moon’s phases are caused by the relative positions of the Sun, Earth, and Moon. As the Moon orbits Earth, we see different portions of its sunlit half, creating the familiar cycle of phases that repeats about every 29.5 days (a lunar month).
 
    📖 Key Terms in Your Example
    "phase_name": "Waxing gibbous"
    This is the descriptive name of the moon’s appearance.
    Waxing = the illuminated portion is increasing.
    Waning = the illuminated portion is decreasing.
    Gibbous = more than half, but not fully illuminated.
    "phase": 0.28480021663618876
 
    This looks like a fraction of the full lunar cycle, where:
    0.0 = New Moon 🌑
    0.25 = First Quarter 🌓
    0.5 = Full Moon 🌕
    0.75 = Last Quarter 🌗
    1.0 = New Moon again
 
    So 0.2848 means the Moon is a little past the First Quarter but not yet Full — which matches "Waxing Gibbous."
    "major_phase": "First Quarter"
    This is the closest main milestone phase.
    Since 0.2848 is closer to 0.25 (First Quarter) than to 0.5 (Full Moon), it’s grouped under First Quarter.
    "stage": "waxing"
    Indicates whether the moon is waxing (growing toward Full Moon) or waning (shrinking toward New Moon).
 
     🌖 What It Looks Like
    “Gibbous” means the Moon is more than half illuminated, but not full.
    “Waning” means the illuminated portion is shrinking each night.
    Visually: the Moon looks round but slightly shrinking, with light still covering most of its face.
    📍 When It Happens
    The Waning Gibbous comes right after the Full Moon.
    In the lunar cycle fraction (0 → 1):
    Full Moon = 0.5
    Last Quarter = 0.75
    Waning Gibbous happens between 0.5 and 0.75.
    So, for example:
    At 0.6 phase → Waning Gibbous
    At 0.7 phase → Still Waning Gibbous, getting close to Last Quarter
 
    🌗 The Main Moon Phases
    New Moon (0.0) → completely dark 🌑
    Waxing Crescent (0.0 → 0.25) → thin crescent growing 🌒
    First Quarter (0.25) → right half lit 🌓
    Waxing Gibbous (0.25 → 0.5) → more than half lit 🌔
    Full Moon (0.5) → fully lit 🌕
    Waning Gibbous (0.5 → 0.75) → shrinking but still > half 🌖
    Last Quarter (0.75) → left half lit 🌗
    Waning Crescent (0.75 → 1.0) → thin crescent fading 🌘
    Back to New Moon (1.0)
 
    ✅ In your case:
    At phase = 0.2848, the Moon is in the Waxing Gibbous stage, just after the First Quarter.
     
 */


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
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color(.systemGray3))
                            .padding(30)
                    })
                }
            }
        }
        VStack {
            Text(currentWeather.moonEmoji)
                .font(.system(size: 130))
                .padding(.top, -50)
            Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")))
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
                    Text("Full Moon")
                        .fontWeight(.bold)
                        .padding(20)
                    
                    Text("New Moon")
                        .fontWeight(.bold)
                        .padding(20)
                    
                    Text("About illumination")
                        .fontWeight(.bold)
                        .padding(20)
                    
                    Text("Illumination refers to the percentage of the moon's Earth-facing surface that is lit up by the sun. A full moon is 100% lit up, and a new moon is 0% lit up. This percentage does not take into account whether the moon is risen or whether there are any clouds, so the number can be above zero even when you can't see the moon.")
                    
                    Text("About Moon Distance")
                        .fontWeight(.bold)
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

