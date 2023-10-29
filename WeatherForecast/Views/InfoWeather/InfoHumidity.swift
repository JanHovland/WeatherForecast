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
    @Binding var weekdayArray: [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var text : String = String(localized: "The average humidity today is ")
    @State private var humidityArray : [Double] = Array(repeating: Double(), count: 24)
    @State private var dewPointArray : [Double] = Array(repeating: Double(), count: 24)

    @State private var text1 : String = String(localized: "Relative humidity, or simply humidity, describes the amount of moisture in the air compared to the maximum amount the air can hold. Air can hold more moisture at higher temperatures. A relative humidity of 100% can lead to dew or fog.")
    
    @State private var text2 : String = String(localized: "The dew point indicates the temperature to which the air must cool before dew occurs. This can provide information about how humid the air feels - the higher the dew point, the more humid it feels. If the dew point is equal to the measured temperature, the relative humidity is 100%, which can lead to dew and fog.")

    var body: some View {
        VStack (alignment: .leading) {
            
            Text(String(localized: "Daily overview"))
                .fontWeight(.bold)
            
            TextField("", text: ($text), axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About relative humidity"))
                .fontWeight(.bold)

            TextField("", text: $text1, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About dew point"))
                .fontWeight(.bold)

            TextField("", text: $text2, axis: .vertical)
                .lineLimit(15)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .font(UIDevice.isIpad ? .subheadline : .caption2)
        .frame(width: UIDevice.isIpad ? 490 : 350,
               height: UIDevice.isIpad ? 400 : 500)
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
                         [NewData]) = FindDataFromMenu(info: "InfoHumidity change index",
                                                       weather: weather,
                                                       date: dateSettings.dates[index],
                                                       option: .humidity,
                                                       option1: .number12)
            humidityArray = value.0
            dewPointArray = value.10
            ///
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            humidityArray: humidityArray,
                            dewPointArray: dewPointArray,
                            weekdayArray: weekdayArray,
                            date: currentWeather.date,
                            offsetSec: weatherInfo.offsetSec)
        }
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
                         [NewData]) = FindDataFromMenu(info: "InfoHumidity .task",
                                                       weather: weather,
                                                       date: dateSettings.dates[index],
                                                       option: .humidity,
                                                       option1: .number12)
            humidityArray = value.0
            dewPointArray = value.10
            ///
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
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
                      offsetSec: Int) -> String {
    
    var text : String = ""
    var weekDay: String = ""
    
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
    
    return text
}
