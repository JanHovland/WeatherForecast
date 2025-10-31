    //
    //  InfoAirPressure.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 13/12/2022.
    //

import SwiftUI
import WeatherKit

struct InfoAirPressure: View {
    
    var index: Int
    var weather: Weather
    var option: EnumType
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var text : String = ""
    @State private var text1 : String = String(localized: "Rapid and significant changes in air pressure are used to predict weather changes. Falling pressure can mean, for example, that rain or snow is in store, while rising pressure can mean better weather. Air pressure is also called atmospheric pressure.")
    @State private var text2 : String = ""
    
    @State private var airPressureArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    @State private var airPressureToDay: Double = 0.00
    @State private var airPressureYesterDay: Double = 0.00
    @State private var factorToDay: Double = 1.00
    @State private var factorYesterDay: Double = 1.00
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
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
                                                             valueToDay: airPressureToDay,
                                                             valueYesterDay: airPressureYesterDay,
                                                             factorToDay: factorToDay,
                                                             factorYesterDay: factorYesterDay))
            
            Text(String(localized: "About air pressure"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 60)
            
            TextField("", text: $text1, axis: .vertical)
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
                /// Finner airPressureArray:
                ///
            airPressureArray.removeAll()
            let value : ([Double],
                         [String],
                         [String],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoAirPressure .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .airPressure,
                                                                option1: .number12)
            
            airPressureArray = value.0
            
                ///
                /// Bygger opp værmeldingen:
                ///
            (text, text2, airPressureToDay, airPressureYesterDay, factorToDay, factorYesterDay)  = Forecast(index: index,
                                                                                                            weather: weather,
                                                                                                            airPressureArray: airPressureArray,
                                                                                                            weekdayArray: weekdayArray,
                                                                                                            date: currentWeather.date,
                                                                                                            offsetSec: weatherInfo.offsetSec)
        }
        
        .onChange(of: index) { oldIndex, index in
                ///
                /// Resetter humidityArray:
                ///
            airPressureArray.removeAll()
            let value : ([Double],
                         [String],
                         [String],
                         [WindInfo],
                         [Temperature],
                         [Double],
                         [WeatherIcon],
                         [Double],
                         [FeltTemp],
                         [Double],
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoAirPressure .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .airPressure,
                                                                option1: .number12)
            
            airPressureArray = value.0
            
                ///
                /// Bygger opp værmeldingen:
                ///
            (text, text2, airPressureToDay, airPressureYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                           weather: weather,
                                                                                                           airPressureArray: airPressureArray,
                                                                                                           weekdayArray: weekdayArray,
                                                                                                           date: currentWeather.date,
                                                                                                           offsetSec: weatherInfo.offsetSec)
            
        }
    }
    
        /// Bygger opp værmeldingen:
        ///
    
    private func Forecast(index: Int,
                          weather: Weather,
                          airPressureArray: [Double],
                          weekdayArray: [String],
                          date: Date,
                          offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
        
        var text = ""
        var text1 = ""
        var weekDay = ""
        
        var toDay = Date()
        var toMorrow = Date()
        var yesterDay = Date()
        
        var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
        var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
        
        var airPressureToDay: Double = 1.00
        var airPressureYesterDay: Double = 1.00
        
        var factorToDay: Double = 1.00
        var factorYesterDay: Double = 1.00
        if index == 0 {
            
            text = text + String(localized: "Now it is ")
            text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec)) " + String(localized: " and ")
            text = text + String(localized: "the airpressure is now ")
            text = text + "\(Int((weather.currentWeather.pressure.value).rounded())) hPa"
            text = text + String(localized: " and ")
            text = text + "\(weather.currentWeather.pressureTrend.description.firstLowercased). "
            text = text + String(localized: "Today the airpressure will be ")
            text = text + "\(Int(FindAverageArray(array: airPressureArray).rounded())) hPa "
            text = text + String(localized: " in average, and the lowest measured pressure will be ")
            text = text + "\(Int(airPressureArray.min()!.rounded())) hPa."
        } else {
            text = String(localized: "On ")
            weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
            text = text + weekDay
            text = text + String(localized: " the airpressure will be ")
            text = text + "\(Int(FindAverageArray(array: airPressureArray).rounded())) hPa "
            text = text + String(localized: " in average, and the lowest measured pressure will be ")
            text = text + "\(Int(airPressureArray.min()!.rounded())) hPa."
        }
            /// Finner luftfuktigheten i dag og i går:toDay
            ///
            toDay = (date.setTime(hour: 0, min: 0, sec: 0)!).adding(days: index)
            toMorrow = toDay.adding(days: 1)
            yesterDay = toDay.adding(days: -1) /// vær obs. på slutt på sommertiden toDay
            arrayToDay.removeAll()
            arrayYesterDay.removeAll()
            hourForecast!.forEach  {
                if $0.date >= toDay &&
                    $0.date < toMorrow {
                    arrayToDay.append(Double($0.pressure.value))
                }
            }
            hourForecast!.forEach  {
                if $0.date >= yesterDay &&
                    $0.date < toDay {
                    arrayYesterDay.append(Double($0.pressure.value))
                }
            }
            ///
            /// Finner den høyest uvIndex  i dag og i går
            ///
            airPressureToDay = FindAverageArray(array: arrayToDay)
            airPressureYesterDay = FindAverageArray(array: arrayYesterDay)
            
            if index == 0 {
                if airPressureToDay > airPressureYesterDay {
                    text1 = String(localized: "The average airpressure today is higher than yesterday.")
                    factorToDay = 1
                    factorYesterDay = airPressureYesterDay / airPressureToDay
                } else if airPressureToDay == airPressureYesterDay {
                    text1 = String(localized: "The average airpressure today is the same as yesterday.")
                    factorToDay = 1.00
                    factorYesterDay = 1.00
                } else {
                    text1 = String(localized: "The average airpressure today is lower than yesterday.")
                    factorToDay = airPressureToDay / airPressureYesterDay
                    factorYesterDay = 1
                }
            } else {
                if airPressureToDay > airPressureYesterDay {
                    text1 = String(localized: "The average airpressure is higher than yesterday.")
                    factorToDay = 1
                    factorYesterDay = airPressureYesterDay / airPressureToDay
                } else if airPressureToDay == airPressureYesterDay {
                    text1 = String(localized: "The average airpressure is the same as yesterday.")
                    factorToDay = 1.00
                    factorYesterDay = 1.00
                } else {
                    text1 = String(localized: "The average airpressure is lower than yesterday.")
                    factorToDay = airPressureToDay / airPressureYesterDay
                    factorYesterDay = 1
                }

            }
            

        return (text, text1, airPressureToDay, airPressureYesterDay, factorToDay, factorYesterDay)
    }
}
