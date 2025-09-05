//
//  InfoVisibility.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/12/2022.
//

import SwiftUI
import WeatherKit

struct InfoVisibility: View {
    
    var index: Int
    @Binding var dayArray : [Double]
    @Binding var weekdayArray: [String]
    var weather: Weather
    
    @State private var text : String = String(localized: "Visibility indicates how far away you can clearly see objects such as buildings or mountain peaks. It is a measure of the transparency of the air and does not take into account the amount of sunlight or obstacles in the field of vision. Visibility of 10 km or more is considered clear.")
    
    @State private var text1 : String = ""
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var visibilityArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .fontWeight(.bold)
            
            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About visibility"))
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)

            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .onChange(of: dayArray) { oldDayArray, dayArray in
            /// Bygger opp værmeldingen:
            ///
            text1 = Forecast(index: index,
                             visibilityArray: visibilityArray,
                             weekdayArray: weekdayArray,
                             date: currentWeather.date,
            offsetSec: weatherInfo.offsetSec)
        }
        .task {
            ///
            /// Finner oversikt ov sikten
            ///
            visibilityArray.removeAll()
            
            let value : ([Double],
                         [String],
                         [String],
                         [RainFall],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "DayDetailWeatherDataFeelsLike change index #1",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .visibility,
                                                                option1: .number24)
            visibilityArray = value.0
            
            ///
            /// Bygger opp værmeldingen:
            ///
            text1 = Forecast(index: index,
                             visibilityArray: visibilityArray,
                             weekdayArray: weekdayArray,
                             date: currentWeather.date,
                             offsetSec: weatherInfo.offsetSec)
        }
    }
}

/// Bygger opp værmeldingen:
///
private func Forecast(index: Int,
                      visibilityArray: [Double],
                      weekdayArray: [String],
                      date: Date,
                      offsetSec: Int) -> String {

    var text : String = ""
    let min = visibilityArray.min()!
    let max = visibilityArray.max()!
    var weekDay: String = ""
    
    if index == 0 {
        text = String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec))"
        text = text + String(localized: " and the visibility is ")
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " the visibility is")
    }
    
    text =  text + (max >= 10.00 ? String(localized: " totally clear, from ") : String(localized: " from "))
    text = text + String(format: "%.f", min) + String(localized: " to ")
    text = text + String(format: "%.0f", max) + String(localized: " miles.")
    
    return text
}

