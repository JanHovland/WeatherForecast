//
//  InfoUvIndex.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI

struct InfoUvIndex : View {
    
    var index: Int

    @Environment(CurrentWeather.self) private var currentWeather

    @Binding var dayArray : [Double]
    @Binding var weatherIcon : [WeatherIcon]
    @Binding var weekdayArray: [String]
    
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var info : String = ""
    @State private var max : Double = 0.00
    @State private var option1: EnumType = .number12
    @State private var text : String = String(localized: "The UV index of the World Health Organization (UVI) measures ultraviolet radiation. The higher the UVI, the greater the chance of skin damage, and the faster the damage can occur. UVI can give you the necessary information about when you should protect yourself from the sun, and when you should avoid staying outdoors. WHO recommends that you stay in the shade or use sunscreen, a hat or protective clothing when the level is 3 (moderate) or higher.")
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(Forecast(index: index,
                          weekdayArray: weekdayArray,
                          max: max,
                          date: currentWeather.date,
                          offsetSec: weatherInfo.offsetSec))
                
            Text(String(localized: "About the UV-index"))
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .font(.subheadline)
        .frame(width: UIDevice.isIpad ? 490 : 350,
               height: UIDevice.isIpad ? 300 : 300)
        .task {
            max = dayArray.max()!
        }
    }
    
}

private func Forecast(index: Int,
                      weekdayArray: [String],
                      max: Double,
                      date: Date,
                      offsetSec: Int) -> String {
    
    var text: String = ""
    var weekDay: String = ""
    
    let text1 = String(localized: " Remember to use suncream, a hat or protective clothing when the level is 3 (moderate) or higher.")
 
    if index == 0 {
        text = String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec))"
        text = text + String(localized: " and ")
        if max < 3.00 {
            text = text + String(localized: " the level is low all day.")
        } else {
            text = text + String(localized: " the level is high all day.")
            text = text + text1
        }
        text = text + "\n"
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        if max < 3.00 {
            text = text + String(localized: " is the level low all day.")
        } else {
            text = text + String(localized: " is level high all day.")
            text = text + text1
        }
        text = text + "\n"
    }
    
    return text
}
