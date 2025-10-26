//
//  InfoHumidity.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/12/2022.
//

import SwiftUI
import WeatherKit
struct InfoHumidity: View {
    
    var index: Int
    var weather: Weather
    var option: EnumType
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var text : String = String(localized: "The average humidity today is ")
    @State private var humidityArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var dewPointArray : [Double] = Array(repeating: Double(), count: sizeArray24)

    @State private var text1 : String = String(localized: "Relative humidity, or simply humidity, describes the amount of moisture in the air compared to the maximum amount the air can hold. Air can hold more moisture at higher temperatures. A relative humidity of 100% can lead to dew or fog.")
    @State private var text2 : String = String(localized: "The dew point indicates the temperature to which the air must cool before dew occurs. This can provide information about how humid the air feels - the higher the dew point, the more humid it feels. If the dew point is equal to the measured temperature, the relative humidity is 100%, which can lead to dew and fog.")
    @State private var text3 : String = ""

    @State private var humidityToDay: Double = 0.00
    @State private var humidityYesterDay: Double = 0.00
    @State private var factorToDay: Double = 1.00
    @State private var factorYesterDay: Double = 1.00
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(String(localized: "Daily overview"))
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("", text: ($text), axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "Daily  differences"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)

            TextField("", text: $text3, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            ///
            /// Viser nivået i dag og i går
            ///
            ProgressView(value: 0.5)
                .progressViewStyle(ProgressViewStyleModifier(option: option,
                                                             valueToDay: humidityToDay,
                                                             valueYesterDay: humidityYesterDay,
                                                             factorToDay: factorToDay,
                                                             factorYesterDay: factorYesterDay))
            
            Text(String(localized: "About relative humidity"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 60)

            TextField("", text: $text1, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About dew point"))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)

            TextField("", text: $text2, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .task {
            ///
            /// Resetter humidityArray:
            ///
            humidityArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoHumidity .task",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .humidity,
                                                                option1: .number12)
            humidityArray = value.0
            dewPointArray = value.10
            ///
            /// Bygger opp værmeldingen:
            ///
            (text, text3, humidityToDay, humidityYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                     humidityArray: humidityArray,
                                                                                                     dewPointArray: dewPointArray,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     date: currentWeather.date,
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }
        .onChange(of: index) { oldIndex, index in
            ///
            /// Resetter humidityArray:
            ///
            humidityArray.removeAll()
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
                         [NewPrecipitation]) = FindDataFromMenu(info: "InfoHumidity change index",
                                                                weather: weather,
                                                                date: dateSettings.dates[index],
                                                                option: .humidity,
                                                                option1: .number12)
            humidityArray = value.0
            dewPointArray = value.10
            ///
            /// Bygger opp værmeldingen:
            ///
            (text, text3, humidityToDay, humidityYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                     humidityArray: humidityArray,
                                                                                                     dewPointArray: dewPointArray,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     date: currentWeather.date,
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }

    }
}

private func Forecast(index: Int,
                      humidityArray: [Double],
                      dewPointArray: [Double],
                      weekdayArray: [String],
                      date: Date,
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
    
    var text : String = ""
    var text1 : String = ""
    var weekDay: String = ""
    
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var humidityToDay: Double = 1.00
    var humidityYesterDay: Double = 1.00
    
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
    if index == 0 {
        text = text + String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec)) " + String(localized: " and ")
        text = String(localized: "the average humidity today is ")
        text = text + "\(Int(FindAverageArray(array: humidityArray).rounded())) %."
        text = text + String(localized: " The dewpoint is between ")
        text = text + "\(Int(dewPointArray.min()!.rounded()))º"
        text = text + String(localized: " and ")
        text = text + "\(Int(dewPointArray.max()!.rounded()))º."
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " will the the humidity be ")
        text = text + "\(Int(FindAverageArray(array: humidityArray).rounded())) %"
        text = text + String(localized: " in average.")
        text = text + String(localized: " The dewpoint is between ")
        text = text + "\(Int(dewPointArray.min()!.rounded()))º"
        text = text + String(localized: " and ")
        text = text + "\(Int(dewPointArray.max()!.rounded()))º."
    }
    ///
    /// Finner luftfuktigheten i dag og i går:
    ///
    toDay = date.setTime(hour: 0, min: 0, sec: 0)!
    toMorrow = toDay.adding(days: 1)
    yesterDay = toDay.adding(days: -1)
    arrayToDay.removeAll()
    arrayYesterDay.removeAll()
    hourForecast!.forEach  {
        if $0.date >= toDay &&
            $0.date < toMorrow {
            arrayToDay.append(Double($0.humidity * 100.0))
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            arrayYesterDay.append(Double($0.humidity * 100.0))
        }
    }
    ///
    /// Finner den høyest uvIndex  i dag og i går
    ///
    humidityToDay = FindAverageArray(array: arrayToDay)
    humidityYesterDay = FindAverageArray(array: arrayYesterDay)
    
    if index == 0 {
        if humidityToDay > humidityYesterDay {
            text1 = String(localized: "The average humidity today is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = humidityYesterDay / humidityToDay
        } else if humidityToDay == humidityYesterDay {
            text1 = String(localized: "The average humidity today is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text1 = String(localized: "The average humidity today is lower than yesterday.")
            factorToDay = humidityToDay / humidityYesterDay
            factorYesterDay = 1
        }
    } else {
        if humidityToDay > humidityYesterDay {
            text1 = String(localized: "The average humidity is higher than yesterday.")
            factorToDay = 1
            factorYesterDay = humidityYesterDay / humidityToDay
        } else if humidityToDay == humidityYesterDay {
            text1 = String(localized: "The average humidity is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text1 = String(localized: "The average humidity is lower than yesterday.")
            factorToDay = humidityToDay / humidityYesterDay
            factorYesterDay = 1
        }

    }
    
    return (text, text1, humidityToDay, humidityYesterDay, factorToDay, factorYesterDay)
}
