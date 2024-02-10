//
//  InfoPrecipitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 01/01/2023.
//

import SwiftUI
import WeatherKit
import MapKit

struct InfoPrecipitation: View {

    let weather: Weather
    var index: Int
    @Binding var dayArray : [Double]
    @Binding var windInfo : [WindInfo]
    @Binding var weekdayArray: [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var text : String = ""
    @State private var text1 : String = String(localized: "")
    @State private var precipitationBackwards: String = ""
    @State private var precipitationForwards: String = ""
    @State private var dataArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var snowArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var precipitationFV: Double = 0.00
    
    var body: some View {
        VStack (alignment: .leading) {
            let sum = snowWarning(snowArray: snowArray)
            if sum > 0.00 {
                Text(String(localized: "Snow warning"))
                    .fontWeight(.bold)
                TextField("", text: $text1, axis: .vertical)
                    .lineLimit(10)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                Text(String(localized: "Daily overview"))
                    .fontWeight(.bold)
                TextField("", text: $text, axis: .vertical)
                    .lineLimit(12)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
            } else {
                Text(String(localized: "Daily overview"))
                    .fontWeight(.bold)
                TextField("", text: $text, axis: .vertical)
                    .lineLimit(10)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .onChange(of: index) { oldIndex, index in
            dataArray.removeAll()
            snowArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoPrecipitation change index",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .precipitation,
                                                                option1: .number12)
            dataArray = value.0
            snowArray = value.8
            ///
            /// Bygger opp værmeldingen:
            ///
            
            let value1: (String, String) = Forecast(index: index,
                                                    dayArray: dayArray,
                                                    weekdayArray: weekdayArray,
                                                    windInfo: windInfo,
                                                    precipitationBackwards: precipitationBackwards,
                                                    precipitationForwards: precipitationForwards,
                                                    dataArray: dataArray,
                                                    precipitationFV: precipitationFV,
                                                    snowArray: snowArray,
                                                    date: currentWeather.date,
                                                    offsetSec: weatherInfo.offsetSec)
            text = value1.0
            text1 = value1.1
            
        }
        .task {
            ///
            /// Resetter dataArray:
            ///
            dataArray.removeAll()
            snowArray.removeAll()
            let value2 : ([Double],
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
                          [NewPrecipitation]) = FindDataFromMenu(info: "InfoPrecipitation .task",
                                                                 weather: weather,
                                                                 date: dateSettings.dates[index],
                                                                 option: .precipitation,
                                                                 option1: .number12)
            dataArray = value2.0
            snowArray = value2.8
            
            let location = CLLocation(latitude:  weatherInfo.latitude!,
                                      longitude: weatherInfo.longitude!)
            
            let value3: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                          location: location,
                                                                          option: .backward,
                                                                          offsetSec: weatherInfo.offsetSec)
            precipitationBackwards = value3.1
            
            let value4: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                          location: location,
                                                                          option: .forward,
                                                                          offsetSec: weatherInfo.offsetSec)
            precipitationForwards = value4.1
            
            precipitationFV = value4.0
            ///
            /// Bygger opp værmeldingen:
            ///
            
            let value5: (String, String) = Forecast(index: index,
                                                    dayArray: dayArray,
                                                    weekdayArray: weekdayArray,
                                                    windInfo: windInfo,
                                                    precipitationBackwards: precipitationBackwards,
                                                    precipitationForwards: precipitationForwards,
                                                    dataArray: dataArray,
                                                    precipitationFV: precipitationFV,
                                                    snowArray: snowArray,
                                                    date: currentWeather.date,
                                                    offsetSec: weatherInfo.offsetSec)
            text = value5.0
            text1 = value5.1
        }
    }
}

private func Forecast(index: Int,
                      dayArray: [Double],
                      weekdayArray: [String],
                      windInfo: [WindInfo],
                      precipitationBackwards: String,
                      precipitationForwards: String,
                      dataArray: [Double],
                      precipitationFV: Double,
                      snowArray: [Double],
                      date: Date,
                      offsetSec: Int) -> (String, String) {

    var text : String = ""
    var text1: String = ""
    var weekDay: String = ""

    if index == 0 {
        text = text + String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec)) " + String(localized: " and ")
        text = text + String(localized: "it has fallen ")
        text = text + precipitationBackwards
        text = text + String(localized: " precification the last 24 hours.\n")
        text = text + String(localized: "To day it will fall totally ")
        let sum = dataArray.reduce(0, +)
        text = text + "\(Int(sum.rounded())) mm "
        text = text + String(localized: "precifitation.\n")
        let rain = precipitationFV
        text = text + String(localized: "The next 24 hours ")
        if rain == 0.00 {
            text = text + String(localized: "it is not expected any precification.\n")
        } else if rain < 1.00 {
            text = text + String(localized: "the total precification amount will be less than 1 mm.\n")
        } else {
            text = text + String(localized: "the total precification amount will be ")
            text = text + precipitationForwards
            text = text + "."
        }
    } else {
        text = text + String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        let sum1 = dataArray.reduce(0, +)
        if sum1 == 0.00 {
            text = text + String(localized: " it will come no rain.")
        } else if sum1 < 1.00 {
            text = text + String(localized: " it will rain less than 1 mm.")
        } else {
            text = text + String(localized: " it will rain ")
            text = text + "\(Int(sum1.rounded()))"
            text = text + String(localized: " mm precipitation.")
        }
    }
    
    text1 = text1 + String(localized: "Distribution of snow versus rain is ")
    let sum2 = snowWarning(snowArray: snowArray)
    let sum3 = dataArray.reduce(0, +)
    let dist = sum2 / sum3 * 100.0
    text1 = text1 + String(format: "%.0f", dist)
    text1 = text1 + "%. "
    text1 = text1 + String(localized: "Please notice that 1 mm rain is equal to 10 mm of snow.")
    
    return (text, text1)
}

func snowWarning(snowArray: [Double]) -> Double {
    
    ///
    /// Sjekker om det kommer snø på en dato:
    ///
    
    let sum = snowArray.reduce(0, +)
    
    if sum > 0.0 {
        return sum
    } else {
        return 0.00
    }
}
