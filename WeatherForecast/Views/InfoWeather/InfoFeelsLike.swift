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
    var option: EnumType
    var weather: Weather
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(CurrentWeather.self) private var currentWeather
    
    @State private var text1 : String = String(localized: "Felt temperature describes how hot or cold it feels outside, and can differ from the actual temperature. Felt temperature is affected by wind and humidity.")
    
    @State private var text2: String = String(localized: "Feels Like conveys how warm or cold it feels and can be different from the actual temperature. The Feels Like temperature is affected by humidity, sunlight and wind.")
    
    @State private var text : String = String(localized: "")
    @State private var fellsLikeArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var feelsLikeToDay: Double = 0.00
    @State private var feelsLikeYesterDay: Double = 0.00
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
            
            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
                ///
                /// Viser nivået i dag og i går
                ///
            ProgressView(value: 0.5)
                .progressViewStyle(ProgressViewStyleModifier(option: option,
                                                             valueToDay: feelsLikeToDay,
                                                             valueYesterDay: feelsLikeYesterDay,
                                                             factorToDay: factorToDay,
                                                             factorYesterDay: factorYesterDay))
            
            Text(String(localized: "About Feels Like Temperature"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 60)
            
            TextField("", text: $text2, axis: .vertical)
                .lineLimit(15)
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
            (text, text1, feelsLikeToDay,feelsLikeYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
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
            (text, text1, feelsLikeToDay,feelsLikeYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
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
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
    var text = ""
    var text1 : String = ""
    var weekDay = ""
    
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var feelsLikeToDay: Double = 1.00
    var feelsLikeYesterDay: Double = 1.00
    
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
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
        ///
        /// Finner føles som  i dag og i går:
        ///
    toDay = (date.setTime(hour: 0, min: 0, sec: 0)!).adding(days: index)
    toMorrow = toDay.adding(days: 1)
    yesterDay = toDay.adding(days: -1)
    arrayToDay.removeAll()
    arrayYesterDay.removeAll()
    hourForecast!.forEach  {
        if $0.date >= toDay &&
            $0.date < toMorrow {
            arrayToDay.append(Double($0.apparentTemperature.value))
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            arrayYesterDay.append(Double($0.apparentTemperature.value))
        }
    }
    
        //
        /// Finner den høyest feels like   i dag og i går
        ///
    feelsLikeToDay = FindAverageArray(array: arrayToDay)
    feelsLikeYesterDay = FindAverageArray(array: arrayYesterDay)
    
    if index == 0 {
        if feelsLikeToDay > feelsLikeYesterDay {
            text1 = String(localized: "The average feels like today is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = feelsLikeYesterDay / feelsLikeToDay
        } else if feelsLikeToDay == feelsLikeYesterDay {
            text1 = String(localized: "The average feels like today is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text1 = String(localized: "The average feels like today is lower than yesterday.")
            factorToDay = feelsLikeToDay / feelsLikeYesterDay
            factorYesterDay = 1
        }
    } else {
        if feelsLikeToDay > feelsLikeYesterDay {
            text1 = String(localized: "The average feels like is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = feelsLikeYesterDay / feelsLikeToDay
        } else if feelsLikeToDay == feelsLikeYesterDay {
            text1 = String(localized: "The average feels like is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text1 = String(localized: "The average feels like is lower than yesterday.")
            factorToDay = feelsLikeToDay / feelsLikeYesterDay
            factorYesterDay = 1
        }
        
    }
    
    return (text, text1, feelsLikeToDay,feelsLikeYesterDay, factorToDay, factorYesterDay)
}
