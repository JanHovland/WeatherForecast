//
//  InfoFeelsLike.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI
import WeatherKit

struct InfoFeelsLike: View {
    
    var index: Int
    var weather: Weather
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(CurrentWeather.self) private var currentWeather

    @State private var text1 : String = String(localized: "Felt temperature describes how hot or cold it feels outside, and can differ from the actual temperature. Felt temperature is affected by wind and humidity.")
    
    @State private var text : String = String(localized: "")
    @State private var fellsLikeArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    @Environment(WeatherInfo.self) private var weatherInfo

    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)

            Text(String(localized: "About felt themperature"))
                .font(.title2)
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
            /// Finner fellsLikeArray:
            ///
            fellsLikeArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoFeelsLike change index",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .feelsLike,
                                                                option1: .number12)
            
            fellsLikeArray = value.0
            
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            weather: weather,
                            fellsLikeArray: fellsLikeArray,
                            weekdayArray: weekdayArray,
                            date: currentWeather.date,
                            offsetSec: weatherInfo.offsetSec)
        }
        .task {
            ///
            /// Finner fellsLikeArray:
            ///
            fellsLikeArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoFeelsLike .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .feelsLike,
                                                                option1: .number12)
            
            fellsLikeArray = value.0
            
            ///
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            weather: weather,
                            fellsLikeArray: fellsLikeArray,
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
                      fellsLikeArray: [Double],
                      weekdayArray: [String],
                      date: Date,
                      offsetSec: Int) -> String {
    var text = ""
    var weekDay = ""
    
    if index == 0 {
        text = text + String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec)) " + String(localized: " and ")
        text = text + String(localized: "the temperature fells like ")
        text = text + "\(Int((weather.currentWeather.apparentTemperature.value).rounded()))º "
        text = text + String(localized: "just now, but the measured temperature is ")
        text = text + "\(Int((weather.currentWeather.temperature.value).rounded()))º. "
        text = text + String(localized: "The wind makes it feel colder. The felt temperatur to day is between ")
        text = text + "\(Int((fellsLikeArray.min())!.rounded()))º "
        text = text + String(localized: " and ")
        text = text + "\(Int((fellsLikeArray.max())!.rounded()))º."
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " will the felt temperature to day be between ")
        text = text + "\(Int((fellsLikeArray.min())!.rounded()))º "
        text = text + String(localized: " and ")
        text = text + "\(Int((fellsLikeArray.max())!.rounded()))º."
        text = text + String(localized: " The wind makes it feel colder than the actual temperature.")
    }
    
    return text
}
