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
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var info : String = ""
    @State private var max : Double = 0.00
    @State private var option1: EnumType = .number12
    @State private var text : String = String(localized: "The UV index of the World Health Organization (UVI) measures ultraviolet radiation. The higher the UVI, the greater the chance of skin damage, and the faster the damage can occur. UVI can give you the necessary information about when you should protect yourself from the sun, and when you should avoid staying outdoors. WHO recommends that you stay in the shade or use sunscreen, a hat or protective clothing when the level is 3 (moderate) or higher.")
    @State private var text1 : String = ""
    @State private var text2 : String = ""
    @State private var uvIndexToDay: Int = 0
    @State private var uvIndexYesterDay: Int = 0
    
    @State private var factorToDay: CGFloat = 1.00
    @State private var factorYesterDay: CGFloat = 1.00
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(text1)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            if index == 0 {
                ///
                ///  Dagsforskjeller:
                ///
                Text("Day differences")
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
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
                    .progressViewStyle(UvIndexProgressViewStyle(uvIndexToDay: uvIndexToDay,
                                                                uvIndexYesterDay: uvIndexYesterDay,
                                                                factorToDay: factorToDay,
                                                                factorYesterDay: factorYesterDay))
            }
            ///
            /// Om uv-imdexen
            ///
            Text(String(localized: "About the UV-index"))
                .fontWeight(.bold)
                .padding(.top, index == 0 ? 20 : 0)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .frame(width: UIDevice.isIpad ? 490 : 350)
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
                      offsetSec: Int) -> (String, String, Int, Int, CGFloat, CGFloat) {
    
    var text: String = ""
    var weekDay: String = ""
    
    let text1 = String(localized: " Remember to use suncream, a hat or protective clothing when the level is 3 (moderate) or higher.")
    var text2: String = ""
    
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Int] = Array(repeating: Int(), count: sizeArray24)
    var arrayYesterDay: [Int] = Array(repeating: Int(), count: sizeArray24)
    
    var uvIndexToDay = Int()
    var uvIndexYesterDay = Int()
    
    var factorToDay: CGFloat = 1.00
    var factorYesterDay: CGFloat = 1.00
    
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
            arrayToDay.append($0.uvIndex.value)
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            arrayYesterDay.append($0.uvIndex.value)
        }
    }
    ///
    /// Finner den høyestuvIndex  i dag og i går
    ///
    uvIndexToDay = arrayToDay.max()!
    uvIndexYesterDay = arrayYesterDay.max()!
    if uvIndexToDay > uvIndexYesterDay {
        text2 = String(localized: "The uvIndex today is higher than yesterday.")
        factorToDay = 1
        factorYesterDay =  CGFloat(uvIndexYesterDay / uvIndexToDay)
    } else if uvIndexYesterDay == uvIndexYesterDay {
        text2 = String(localized: "The uvIndex today is the same as yesterday.")
        factorToDay = 1.00
        factorYesterDay = 1.00
    } else {
        text2 = String(localized: "The uvIndex today is lower than yesterday.")
        factorToDay = CGFloat(uvIndexToDay / uvIndexYesterDay)
        factorYesterDay = 1
    }

    return (text, text2, uvIndexToDay, uvIndexYesterDay, factorToDay, factorYesterDay)
    
}

struct UvIndexProgressViewStyle: ProgressViewStyle {
    var uvIndexToDay: Int
    var uvIndexYesterDay: Int
    var factorToDay: CGFloat
    var factorYesterDay: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        VStack (alignment: .leading) {
            HStack {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: (UIDevice.isIpad ? 430 : 290) * factorToDay, height: 20)
                        .foregroundColor(.white)
                        .overlay (
                            HStack {
                                Text("I dag")
                                    .foregroundStyle(.black)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                        )
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(uvIndexToDay)")
                }
            }
            HStack {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: (UIDevice.isIpad ? 430 : 290) * factorYesterDay, height: 20)
                        .foregroundColor(.gray)
                        .overlay (
                            HStack {
                                Text("I går")
                                    .padding(.leading, 5)
                                Spacer()
                            }
                        )
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(uvIndexYesterDay)")
                }
            }
        }
        .padding(5)
    }
}

