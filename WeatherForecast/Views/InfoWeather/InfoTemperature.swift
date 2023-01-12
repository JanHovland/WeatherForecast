//
//  InfoTemperature.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI

struct InfoTemperature : View {
    
    var index: Int
    @Binding var dayArray: [Double]
    @Binding var tempInfo: [Temperature]
    @Binding var weekdayArray: [String]
    
    @State private var text : String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(index == 0 ? String(localized: "Weather forecast") : String(localized: "Daily view"))
                .fontWeight(.bold)
            
           TextField("", text: $text, axis: .vertical)
                .lineLimit(0...10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .font(.subheadline)
        .frame(width: UIDevice.isIpad ? 490 : 350,
               height: UIDevice.isIpad ? 300 : 300)
        .onChange(of: index) { index in
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            dayArray: dayArray,
                            weekdayArray: weekdayArray,
                            tempInfo: tempInfo)
        }
        .task {
            /// Bygger opp værmeldingen:
            ///
            text = Forecast(index: index,
                            dayArray: dayArray,
                            weekdayArray: weekdayArray,
                            tempInfo: tempInfo)
        }
    }
}

/// Bygger opp værmeldingen:
///
private func Forecast(index: Int,
                      dayArray: [Double],
                      weekdayArray: [String],
                      tempInfo: [Temperature]) -> String {
    
    var dayTempInfo: [DayTempInfo] = []
    
    var text: String = ""
    var weekDay: String = ""
    
    var minTemp: Double = 0.00
    var maxTemp: Double = 0.00
    var maxWind: Double = 0.00
    var maxGust: Double = 0.00
    var minAppearentTemp: Double = 0.00
    var maxAppearentTemp: Double = 0.00

    var indexMin: Int = 0
    var indexMax: Int = 0
    var indexMaxWind: Int = 0
    var indexMaxGust: Int = 0
    
    var indexMinAppearentTemp: Int = 0
    var indexMaxAppearentTemp: Int = 0

    ///
    /// Finner minimum temperaturen (vanlig temperatur) :
    ///
    let value: (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                             option: .tempTemp,
                                                             option1: .min,
                                                             type: tempType)
    minTemp = value.0
    indexMin = value.1
    dayTempInfo = value.2
    ///
    /// Finner maximum temperaturen (vanlig temperatur) :
    ///
    let value1: (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                              option: .tempTemp,
                                                              option1: .max,
                                                              type: tempType)
    maxTemp = value1.0
    indexMax = value1.1
    dayTempInfo = value.2
    ///
    /// Finner maximum vind hastighet  (vanlig temperatur) :
    ///
    let value2 : (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                               option: .windSpeed,
                                                               option1: .max,
                                                               type: tempType)
    maxWind = value2.0
    indexMaxWind = value2.1
    dayTempInfo = value2.2
    ///
    /// Finner maximum vindkast (vanlig temperatur) :
    ///
    let value3 : (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                               option: .gustSpeed,
                                                               option1: .max,
                                                               type: tempType)
    maxGust = value3.0
    indexMaxGust = value3.1
    dayTempInfo = value3.2
    ///
    /// Finner minimum følt temperatur  :
    ///
    let value4 : (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                               option: .appearentTemp,
                                                               option1: .min,
                                                               type: appearentType)
    minAppearentTemp = value4.0
    indexMinAppearentTemp = value4.1
    
    ///
    /// Finner minimum følt temperatur  :
    ///
    let value5 : (Double, Int, [DayTempInfo]) = TempInfoValues(tempInfo: tempInfo,
                                                               option: .appearentTemp,
                                                               option1: .max,
                                                               type: appearentType)
    maxAppearentTemp = value5.0
    indexMaxAppearentTemp = value5.1

    if index == 0 {
        text = ""
        ///
        /// Legger inn temperaturen akkurat nå:
        ///
        text = text + String(localized: "Now it is ")
        text = text + "\(Int(tempInfo[tempType].data[IndexPointMarkFromHour()].temp.rounded()))" + "º"
        text = text + String(localized: " and ")
        text = text + tempInfo[tempType].data[IndexPointMarkFromHour()].condition.firstLowercased
        text = text + "."
        text = text + "\n"
        ///
        /// Legger inn høyeste vind hastighet:
        ///
        text = text + String(localized: "Max windspeed ")
        text = text + "\(Int((maxWind).rounded()))" + " m/s"
        text = text + String(localized: " at ")
        text = text + IndexToHour(index: indexMaxWind)
        text = text + ".\n"
        ///
        // Legger inn høyeste vindkast:
        ///
        text = text + String(localized: "Max gust ")
        text = text + "\(Int((maxGust).rounded()))" + " m/s"
        text = text + String(localized: " at ")
        text = text + IndexToHour(index: indexMaxGust)
        text = text + ".\n"
        ///
        /// Legger inn temperaturen for dagent:
        ///
        text = text + WeatherOverView(dayTempInfo: dayTempInfo)
        text = text + String(localized: "The temperature today will extend from ")
        text = text + "\(Int(minTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " to ")
        text = text + "\(Int(maxTemp.rounded()))"
        text = text + "º.\n"
        ///
        /// Legger inn følt temperatur for dagent:
        ///
        text = text + String(localized: "The felt temperature today will extend from ")
        text = text + "\(Int(minAppearentTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " to ")
        text = text + "\(Int(maxAppearentTemp.rounded()))"
        text = text + "º."
    } else {
        ///
        /// Legger inn laveste og høyeste temperatur:
        ///
        text = String(localized: "The lowest temperature on ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " will be ")
        text = text + "\(Int(minTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " at ")
        text = text + IndexToHour(index: indexMin)
        text = text + ",\n"
        text = text + String(localized: "the highest ")
        text = text + "\(Int(maxTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " kl. ")
        text = text + IndexToHour(index: indexMax)
        text = text + ".\n"
        ///
        /// Legger inn laveste og høyeste følt temperatur:
        ///
        text = text + String(localized: "The lowest felt temperature on ")
        text = text + String(localized: " will be ")
        text = text + "\(Int(minAppearentTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " at ")
        text = text + IndexToHour(index: indexMinAppearentTemp)
        text = text + ",\n"
        text = text + String(localized: "the highest ")
        text = text + "\(Int(maxAppearentTemp.rounded()))"
        text = text + "º"
        text = text + String(localized: " kl. ")
        text = text + IndexToHour(index: indexMaxAppearentTemp)
        text = text + "."
    }
    
    return text
}

private func TempInfoValues(tempInfo: [Temperature],
                            option : EnumType,
                            option1 : EnumType,
                            type: Int) -> (Double, Int, [DayTempInfo]) {
    
    /// option  = tempTemp, appearentTemp eller gustTemp
    /// option1 = min eller max
    
    var value: Double = 0.00
    var index: Int = 0
    var array: [Double] = []
    var dayTempInfo: [DayTempInfo] = []
    var dayTempInfo1 = DayTempInfo()
    
    array.removeAll()
    dayTempInfo.removeAll()
    ///
    /// Finner data fra tempType == 0 som er vanlig temperatur:
    ///
    for i in 0..<tempInfo[type].data.count {
        if option == .tempTemp {
            array.append(tempInfo[tempType].data[i].temp)
        } else if option == .windSpeed {
            array.append(tempInfo[tempType].data[i].wind)
        } else if option == .gustSpeed {
            array.append(tempInfo[tempType].data[i].gust)
        } else if option == .appearentTemp {
            array.append(tempInfo[appearentType].data[i].temp)
        }
    }
    ///
    /// Finner min og max:
    ///
    if type == tempType {
        if option1 == .min {
            value = array.min()!
        } else if option1 == .max {
            value = array.max()!
        }
        /// Finn index til value:
        ///
        for i in 0..<array.count {
            if array[i] == value {
                index = i
                break
            }
        }
    } else if type == appearentType {
        if option1 == .min {
            value = array.min()!
        } else if option1 == .max {
            value = array.max()!
        }
    }
    
    /// Bygger opp [dayTempInfo] :
    ///
    for i in 0..<tempInfo.count {
        dayTempInfo1.condition = tempInfo[tempType].data[i].condition
        dayTempInfo1.hour = IndexToHour(index: i)
        dayTempInfo1.type = tempInfo[tempType].data[i].condition
        dayTempInfo.append(dayTempInfo1)
    }
    return (value, index, dayTempInfo)
}

func IndexToHour(index: Int) -> String {
    return index < 10 ? "0\(index):00" : "\(index):00"
}

private func WeatherOverView(dayTempInfo: [DayTempInfo]) -> String {
    
    var text: String = ""
    var tempType: String = ""
    
    var from: String = ""
    var to: String = ""
    
    var weatherTypes: [WeatherType] = []
    weatherTypes.removeAll()

    var weatherType = WeatherType()
    
    var firstType: String = ""
    var secondType: String = ""
    var thirdType: String = ""
    
    for i in 0..<dayTempInfo.count {
        if i == 0 {
            from = dayTempInfo[i].hour
            tempType = dayTempInfo[i].type
        }
        if dayTempInfo[i].type == tempType {
            tempType = dayTempInfo[i].type
        } else {
            ///
            /// Avslutter den første værtypen:
            ///
            to = dayTempInfo[i].hour
            weatherType.type = tempType
            weatherType.from = from
            weatherType.to = to
            weatherTypes.append(weatherType)
            ///
            /// Setter tempType til neste værtype:
            /// Setter "from" til dayTempInfo[i].hour:
            ///
            tempType = dayTempInfo[i].type
            from = dayTempInfo[i].hour
        }
    }
    ///
    /// Legger til den siste posten:
    ///
    weatherType.type = tempType
    weatherType.from = from
    weatherType.to = "00:00"
    weatherTypes.append(weatherType)
    ///
    /// Finner firstType, secondType og thirdType:
    ///
    for i in 0..<weatherTypes.count {
        if i == 0 {
            firstType = weatherTypes[i].type
        } else {
            if weatherTypes[i].type != firstType &&
                weatherTypes[i].type != thirdType {
                secondType = weatherTypes[i].type
            } else if weatherTypes[i].type != firstType &&
                        weatherTypes[i].type != secondType {
                thirdType = weatherTypes[i].type
            }
        }
    }
    ///
    /// Finner textene til de tre værtypene:
    ///
    text = TextFromWeatherType(weatherTypes : weatherTypes, type: firstType)
    text = text + TextFromWeatherType(weatherTypes : weatherTypes, type: secondType)
    text = text + TextFromWeatherType(weatherTypes : weatherTypes, type: thirdType)
    
    return text
}

func TextFromWeatherType(weatherTypes : [WeatherType], type: String) -> String {
    
    var counter: Int = 0
    var text: String = type.firstUppercased
    
    var from: String = ""
    var to: String = ""
    
    ///
    /// Finn  counter :
    ///
    for i in 0..<weatherTypes.count {
        if weatherTypes[i].type == type {
            counter = counter + 1
        }
    }
    ///
    /// Finn text som hører til "type":
    ///
    if counter > 0 {
        var j: Int = 0
        for i in 0..<weatherTypes.count {
            if weatherTypes[i].type == type {
                j = j + 1
                text = text + String(localized: " from ")
                text = text + weatherTypes[i].from
                from = weatherTypes[i].from
                text = text + String(localized: " to ")
                text = text + weatherTypes[i].to
                to =  weatherTypes[i].to
                if j < counter - 1 {
                    text = text + ","
                } else {
                    if j < counter {
                        text = text + String(localized: " and")
                    }
                }
            }
        }
        if from == "00:00" && to == "00:00" {
            text = type.firstUppercased + String(localized: " hele dagen")
            text = text + ".\n"
        } else {
            text = text + ".\n"
        }
   }

    return text
}





