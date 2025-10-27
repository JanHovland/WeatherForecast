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
    var option: EnumType
    
    @State private var text : String = String(localized: "Visibility indicates how far away you can clearly see objects such as buildings or mountain peaks. It is a measure of the transparency of the air and does not take into account the amount of sunlight or obstacles in the field of vision. Visibility of 10 km or more is considered clear.")
    
    @State private var text1 : String = ""
    @State private var text2 : String = ""
    
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    
    @State private var visibilityToDay: Double = 0.00
    @State private var visibilityYesterDay: Double = 0.00
    @State private var factorToDay: Double = 1.00
    @State private var factorYesterDay: Double = 1.00
    
    
    @State private var visibilityArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "Daily  differences"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
            
            TextField("", text: $text2, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                ///
                /// Viser nivået i dag og i går
                ///
            ProgressView(value: 0.5)
                .progressViewStyle(ProgressViewStyleModifier(option: option,
                                                             valueToDay: visibilityToDay,
                                                             valueYesterDay: visibilityYesterDay,
                                                             factorToDay: factorToDay,
                                                             factorYesterDay: factorYesterDay))
            
            Text(String(localized: "About visibility"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 60)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
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
            (text1, text2, visibilityToDay, visibilityYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                          visibilityArray: visibilityArray,
                                                                                                          weekdayArray: weekdayArray,
                                                                                                          date: currentWeather.date,
                                                                                                          offsetSec: weatherInfo.offsetSec)
        }
            // .onChange(of: dayArray) { oldDayArray, dayArray in
        .onChange(of: index) { oldIndex, index in
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
            (text1, text2, visibilityToDay, visibilityYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                          visibilityArray: visibilityArray,
                                                                                                          weekdayArray: weekdayArray,
                                                                                                          date: dateSettings.dates[index],
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
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
    
    var text1: String = ""
    var text2: String = ""
    let min = visibilityArray.min()!
    let max = visibilityArray.max()!
    var weekDay: String = ""
    
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var visibilityToDay: Double = 1.00
    var visibilityYesterDay: Double = 1.00
    
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
    if index == 0 {
        text1 = String(localized: "Now it is ")
        text1 = text1 + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec))"
        text1 = text1 + String(localized: " and the visibility is ")
    } else {
        text1 = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text1 = text1 + weekDay
        text1 = text1 + String(localized: " the visibility is")
    }
    
    text1 = text1 + (max >= 10.00 ? String(localized: " totally clear, from ") : String(localized: " from "))
    text1 = text1 + String(format: "%.f", min) + String(localized: " to ")
    text1 = text1 + String(format: "%.0f", max) + String(localized: " miles.")
    
        ///
        /// Finner luftfuktigheten i dag og i går:
        ///
    toDay = (date.setTime(hour: 0, min: 0, sec: 0)!)
    toMorrow = toDay.adding(days: 1)
    yesterDay = toDay.adding(days: -1).setTime(hour: 0, min: 0, sec: 0) ?? Date()
    arrayToDay.removeAll()
    arrayYesterDay.removeAll()
    hourForecast!.forEach  {
        if $0.date >= toDay &&
            $0.date < toMorrow {
            arrayToDay.append(Double($0.visibility.value))
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            arrayYesterDay.append(Double($0.visibility.value))
        }
    }
        ///
        /// Finner den høyest uvIndex  i dag og i går
        ///
    visibilityToDay = FindAverageArray(array: arrayToDay) / 1000.0
    visibilityYesterDay = FindAverageArray(array: arrayYesterDay) / 1000.0
    
    if index == 0 {
        if visibilityToDay > visibilityYesterDay {
            text2 = String(localized: "The average visibility today is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = visibilityYesterDay / visibilityToDay
        } else if visibilityToDay == visibilityYesterDay {
            text2 = String(localized: "The average visibility today is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text2 = String(localized: "The average visibility today is lower than yesterday.")
            factorToDay = visibilityToDay / visibilityYesterDay
            factorYesterDay = 1
        }
    } else {
        if visibilityToDay > visibilityYesterDay {
            text2 = String(localized: "The average visibility is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = visibilityYesterDay / visibilityToDay
            
        } else if visibilityToDay == visibilityYesterDay {
            text2 = String(localized: "The average visibility is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text2 = String(localized: "The average visibility is lower than yesterday.")
            factorToDay = visibilityToDay / visibilityYesterDay
            factorYesterDay = 1
        }
        
    }
    
    return (text1, text2, visibilityToDay, visibilityYesterDay, factorToDay, factorYesterDay)
}

