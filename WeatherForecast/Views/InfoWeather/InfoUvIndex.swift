//
//  InfoUvIndex.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI

struct InfoUvIndex : View {
    
    var index: Int
    var option: EnumType
    
    @Binding var dayArray : [Double]
    @Binding var weatherIcon : [WeatherIcon]
    @Binding var weekdayArray: [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var info : String = ""
    @State private var max : Double = 0.00
    @State private var option1: EnumType = .number12
    @State private var text : String = String(localized: "The UV index of the World Health Organization (UVI) measures ultraviolet radiation. The higher the UVI, the greater the chance of skin damage, and the faster the damage can occur. UVI can give you the necessary information about when you should protect yourself from the sun, and when you should avoid staying outdoors. WHO recommends that you stay in the shade or use sunscreen, a hat or protective clothing when the level is 3 (moderate) or higher.")
    @State private var text1 : String = ""
    @State private var text2 : String = ""
    
    @State private var uvIndexToDay: Double = 0.00
    @State private var uvIndexYesterDay: Double = 0.00
    @State private var factorToDay: Double = 1.00
    @State private var factorYesterDay: Double = 1.00
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(text1)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding(.top, 60)
            
            if index == 0 {
                ///
                ///  Dagsforskjeller:
                ///
                Text("Day differences")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                ///
                /// info om forskjellene
                ///
                TextField("", text: $text2, axis: .vertical)
                    .lineLimit(12)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                ///
                /// Viser nivået i dag og i går
                ///
                ProgressView(value: 0.5)
                    .progressViewStyle(ProgressViewStyleModifier(option: option,
                                                                 valueToDay: uvIndexToDay,
                                                                 valueYesterDay: uvIndexYesterDay,
                                                                 factorToDay: factorToDay,
                                                                 factorYesterDay: factorYesterDay))
            }
            ///
            /// Om uv-imdexen
            ///
            Text(String(localized: "About the UV-index"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)

            TextField("", text: $text, axis: .vertical)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        ///
        /// Legg merke til maxHeight ikke må begrense scrollimg, så legg inn en stor verdi.
        ///
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .task {
            max = dayArray.max()!
            
            (text1, text2, uvIndexToDay, uvIndexYesterDay, factorToDay, factorYesterDay) =  Forecast(index: index,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     max: max,
                                                                                                     date: dateSettings.dates[index],
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }
        .onChange(of: index) { oldIndex, index in
            
            (text1, text2, uvIndexToDay, uvIndexYesterDay, factorToDay, factorYesterDay) =  Forecast(index: index,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     max: max,
                                                                                                     date: dateSettings.dates[index],
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }
    }
    
}

private func Forecast(index: Int,
                      weekdayArray: [String],
                      max: Double,
                      date: Date,
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
    
    var text: String = ""
    var weekDay: String = ""
    @Environment(WeatherInfo.self) var weatherInfo
    
    let text1 = String(localized: " Remember to use suncream, a hat or protective clothing when the level is 3 (moderate) or higher.")
    var text2: String = ""
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var uvIndexToDay: Double = 1.00
    var uvIndexYesterDay: Double = 1.00
    
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
    if index == 0 {
        text = String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: Date().adding(seconds: offsetSec), format: ("EEEE d. MMMM HH:mm"), offsetSec: 0))"
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
    ///
    /// Finner Uv-indeks i dag og i går:
    ///
    toDay = date.setTime(hour: 0, min: 0, sec: 0)!
    toMorrow = toDay.adding(days: 1)
    yesterDay = toDay.adding(days: -1)
    arrayToDay.removeAll()
    arrayYesterDay.removeAll()
    hourForecast!.forEach  {
        if $0.date >= toDay &&
            $0.date < toMorrow {
            arrayToDay.append(Double($0.uvIndex.value))
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            arrayYesterDay.append(Double($0.uvIndex.value))
        }
    }
    ///
    /// Finner den høyest uvIndex  i dag og i går
    ///
    uvIndexToDay = Double(arrayToDay.max()!)
    uvIndexYesterDay = Double(arrayYesterDay.max()!)
    if uvIndexToDay > uvIndexYesterDay {
        text2 = String(localized: "The uvIndex today is higher than yesterday.")
        factorToDay = 1
        factorYesterDay = uvIndexYesterDay / uvIndexToDay
    } else if uvIndexToDay == uvIndexYesterDay {
        text2 = String(localized: "The uvIndex today is the same as yesterday.")
        factorToDay = 1.00
        factorYesterDay = 1.00
    } else {
        text2 = String(localized: "The uvIndex today is lower than yesterday.")
        factorToDay = uvIndexToDay / uvIndexYesterDay
        factorYesterDay = 1
    }
    /// https://stackoverflow.com/questions/34929932/round-up-double-to-2-decimal-places?rq=3
    return (text, text2, uvIndexToDay, uvIndexYesterDay, factorToDay, factorYesterDay)
    
}

