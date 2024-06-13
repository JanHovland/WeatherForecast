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
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings

    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var text1 : String = String(localized: "Rapid and significant changes in air pressure are used to predict weather changes. Falling pressure can mean, for example, that rain or snow is in store, while rising pressure can mean better weather. Air pressure is also called atmospheric pressure.")
    
    @State private var text : String = ""
    
    @State private var airPressureArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About air pressure"))
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)

            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .onChange(of: index) { oldIndex, index in
            ///
            /// Finner airPressureArray:
            ///
            airPressureArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoAirPressure change index",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .airPressure,
                                                                option1: .number12)
            
            airPressureArray = value.0
            
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            weather: weather,
                            airPressureArray: airPressureArray,
                            weekdayArray: weekdayArray,
                            date: currentWeather.date,
                            offsetSec: weatherInfo.offsetSec)
        }
        .task {
            ///
            /// Finner airPressureArray:
            ///
            airPressureArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoAirPressure .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .airPressure,
                                                                option1: .number12)
            
            airPressureArray = value.0
            
            ///
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            weather: weather,
                            airPressureArray: airPressureArray,
                            weekdayArray: weekdayArray,
                            date: currentWeather.date,
                            offsetSec: weatherInfo.offsetSec)
        }
    }
}

/// Bygger opp værmeldingen:
///

private func Forecast(index: Int,
                      weather: Weather,
                      airPressureArray: [Double],
                      weekdayArray: [String],
                      date: Date,
                      offsetSec: Int) -> String {
    
    var text = ""
    var weekDay = ""
    
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
    
    return text
}
