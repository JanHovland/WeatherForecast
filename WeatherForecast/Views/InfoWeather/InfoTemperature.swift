//
//  InfoTemperature.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI
import WeatherKit
import Charts

struct InfoTemperature : View {
    
    @Binding var index: Int
    
    var option: EnumType
    @Binding var dayArray: [Double]
    @Binding var tempInfo: [Temperature]
    @Binding var weekdayArray: [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var text: String = ""
    @State private var text1: String = ""
    @State private var text2: String = String(localized: "Freshly fallen dry snow has a water value of around 0.1, which means that 10 centimeters of snow when melted gives 1 centimeter of water. 1 millimeter of precipitation gives a snow depth of 10 millimeters. In older snow, many of the snow crystals' small spikes and sharp edges have disappeared. The rounder crystals take up less space, and the snow sinks together. The higher the temperature, the faster this process goes. Fresh snow can have a water value of up to 0.2–0.3 if it accumulates while it is snowing. Beyond spring, the water value of the snow cover is usually 0.2–0.3 in the lowlands and 0.3–0.5 in mountainous areas.")
    
    @State private var text3: String = String(localized: "Feels Like conveys how warm or cold it feels and can be different from the actual temperature. The Feels Like temperature is affected by humidity, sunlight and wind.")
    
    @State private var feltTempToDay: Double = 0.00
    @State private var feltTempYesterDay: Double = 0.00
    
    @State private var min: Double = 0.00
    @State private var max: Double = 0.00
    @State private var minIndex: Int = 0
    @State private var maxIndex: Int = 0
    
    @State private var newProbability: [NewProbability] = []
    @State private var precification = Precipitation()
    
    @State private var factorToDay: Double = 1.00
    @State private var factorYesterDay: Double = 1.00

    var body: some View {
        VStack (alignment: .leading) {
            ///
            /// Overskrift:
            ///
            Text("Probability of precipitation")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            ///
            /// Viser Chart for "Sannsynlighet for nedbør"
            ///
            ChartViewNewProbability(index: index,
                                    newData: newProbability,
                                    min: min,
                                    minIndex: minIndex,
                                    max: max,
                                    maxIndex: maxIndex)
            ///
            /// Total nedbørsmengde
            ///
            Text("Total amount of precipitation")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
            ///
            /// Dersom det er kommet snø kommer dette opp:
            ///
            if precification.snowLast24 > 0.00 ||
                precification.snowNext24 > 0.00 ||
                precification.snowThisDay > 0.00 {
                TextField("", text: $text2, axis: .vertical)
                    .lineLimit(20)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                    .padding(.horizontal, 10)
            }
            ///
            /// Ved index > 0 vises vises oversikt over nedbør siste 24t og neste 24t
            ///
            if index == 0 {
                VStack (alignment: .leading) {
                    ///
                    /// Viser nedbør de siste 24 timene
                    ///
                    Text("LAST 24 HOURS")
                        .opacity(0.50)
                        .padding(.top, 10)
                    if precification.rainLast24 == 0.00,
                        precification.snowLast24 == 0.00,
                        precification.hailLast24 == 0.00,
                        precification.mixedLast24 == 0.00,
                        precification.sleetLast24 == 0.00 {
                        HStack {
                            HStack {
                                Text("Precification")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("0.0 mm")
                            }
                        }
                    } else {
                        if precification.rainLast24 > 0.00 {
                            ShowItem(heading: String(localized: "Rain "), value: precification.rainLast24)
                        }
                        if precification.snowLast24 > 0.00 {
                            ShowItem(heading: String(localized: "Snow"), value: precification.snowLast24)
                        }
                        if precification.hailLast24 > 0.00 {
                            ShowItem(heading: String(localized: "Hail"), value: precification.hailLast24)
                        }
                        if precification.mixedLast24 > 0.00 {
                            ShowItem(heading: String(localized: "Mixed"), value: precification.mixedLast24)
                        }
                        if precification.sleetLast24 > 0.00 {
                            ShowItem(heading: String(localized: "Sleet"), value: precification.sleetLast24)
                        }
                    }
                    ///
                    /// Viser nedbør de neste 24 timene
                    ///
                    Text("NEXT 24 HOURS")
                        .opacity(0.50)
                        .padding(.top, 20)
                    if precification.rainNext24 == 0.00,
                        precification.snowNext24 == 0.00,
                        precification.hailNext24 == 0.00,
                        precification.mixedNext24 == 0.00,
                        precification.sleetNext24 == 0.00 {
                        HStack {
                            HStack {
                                Text("Precification")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("0.0 mm")
                            }
                        }
                    } else {
                        if precification.rainNext24 > 0.00 {
                            ShowItem(heading: String(localized: "Rain "), value: precification.rainNext24)
                        }
                        if precification.snowNext24 > 0.00 {
                            ShowItem(heading: String(localized: "Snow"), value: precification.snowNext24)
                        }
                        if precification.hailNext24 > 0.00 {
                            ShowItem(heading: String(localized: "Hail"), value: precification.hailNext24)
                        }
                        if precification.mixedNext24 > 0.00 {
                            ShowItem(heading: String(localized: "Mixed"), value: precification.mixedNext24)
                        }
                        if precification.sleetNext24 > 0.00 {
                            ShowItem(heading: String(localized: "Sleet"), value: precification.sleetNext24)
                        }
                    }
                }
            } else {
                ///
                /// Viser oversikt over nedbør denne dagen
                ///
                if precification.rainThisDay == 0.00,
                    precification.snowThisDay == 0.00,
                    precification.hailThisDay == 0.00,
                    precification.mixedThisDay == 0.00,
                    precification.sleetThisDay == 0.00 {
                    HStack {
                        HStack {
                            Text("Precification")
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("0.0 mm")
                        }
                    }
                } else {
                    if precification.rainThisDay > 0.00 {
                        ShowItem(heading: String(localized: "Rain "), value: precification.rainThisDay)
                    }
                    if precification.snowThisDay > 0.00 {
                        ShowItem(heading: String(localized: "Snow"), value: precification.snowThisDay)
                    }
                    if precification.hailThisDay > 0.00 {
                        ShowItem(heading: String(localized: "Hail"), value: precification.hailThisDay)
                    }
                    if precification.mixedThisDay > 0.00 {
                        ShowItem(heading: String(localized: "Mixed"), value: precification.mixedThisDay)
                    }
                    if precification.sleetThisDay > 0.00 {
                        ShowItem(heading: String(localized: "Sleet"), value: precification.sleetThisDay)
                    }
                }
            }
            ///
            /// Værvarsel:
            ///
            Text("WeatherForecast")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
          
            TextField("", text: $text, axis: .vertical)
                .lineLimit(20)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding(.horizontal, 10)
            ///
            ///  Dagsforskjeller:
            ///
            Text("Day differences")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
            ///
            /// Viser dagsforskjellene på følt temperatur
            ///
            TextField("", text: $text1, axis: .vertical)
                .font(.title3)
                .lineLimit(20)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding(.horizontal, 10)
            if UIDevice.isIpad {
                
            }
            ProgressView(value: 0.5)
                .progressViewStyle(ProgressViewStyleModifier(
                    option: option,
                    valueToDay: feltTempToDay,
                    valueYesterDay: feltTempYesterDay,
                    factorToDay: factorToDay,
                    factorYesterDay: factorYesterDay))
            
            Text("About Feels Like Temperature")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 60)
            
            
            TextField("", text: $text3, axis: .vertical)
                .lineLimit(20)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .padding(.horizontal, 10)
            if UIDevice.isIpad {
                
            }
            
                       
        }
        ///
        /// Legg merke til maxHeight ikke må begrense scrollimg, så legg inn en stor verdi.
        ///
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .task {
            ///
            /// Finner newProbability
            ///
            (newProbability, min, minIndex, max, maxIndex, precification) = FindChartDataProbability(date: dateSettings.dates[index],
                                                                                                     index: index)
            ///
            /// Bygger opp værmeldingen:
            ///
            (text, text1, feltTempToDay, feltTempYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                     dayArray: dayArray,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     tempInfo: tempInfo,
                                                                                                     date: dateSettings.dates[index],
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }
        .onChange(of: index) { oldIndex, index in
            ///
            /// Finner newProbability
            ///
            (newProbability, min, minIndex, max, maxIndex, precification) = FindChartDataProbability(date: dateSettings.dates[index],
                                                                                                     index: index)
            ///
            /// Bygger opp værmeldingen:
            ///
            (text, text1, feltTempToDay, feltTempYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                                     dayArray: dayArray,
                                                                                                     weekdayArray: weekdayArray,
                                                                                                     tempInfo: tempInfo,
                                                                                                     date: dateSettings.dates[index],
                                                                                                     offsetSec: weatherInfo.offsetSec)
        }
    }
}

struct ShowItem: View {
    let heading: String
    let value: Double
    
    var body: some View {
        HStack {
            HStack {
                if heading.contains(String(localized: "Rain ")) {
                    HStack {
                        Text("🔵")
                            .font(.system(size: 7))
                         Text(" " + heading)
                        Spacer()
                    }
                } else if heading.contains(String(localized: "Snow")) {
                    HStack {
                        Text("⚪️")
                            .font(.system(size: 7))
                        Text(" " + heading)
                        Spacer()
                    }
                } else if heading.contains(String(localized: "Hail")) {
                    HStack {
                        Text("🔴")
                            .font(.system(size: 7))
                        Text(" " + heading)
                        Spacer()
                    }
                } else if heading.contains(String(localized: "Mixed")) {
                    HStack {
                        Text("🟣")
                            .font(.system(size: 7))
                        Text(" " + heading)
                        Spacer()
                    }
                } else if heading.contains(String(localized: "Sleet")) {
                    HStack {
                        Text("🟡")
                            .font(.system(size: 7))
                        Text(" " + heading)
                        Spacer()
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                let string = String(format: "%.1f", value).replacingOccurrences(of: ".", with: ",")
                Text(string + " mm")
            }
        }
        .modifier(ShowItemViewModifier(heading: heading))
        
    }
}

///
/// Bygger opp værmeldingen:
///
private func Forecast(index: Int,
                      dayArray: [Double],
                      weekdayArray: [String],
                      tempInfo: [Temperature],
                      date: Date,
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {
    
    
    var dayTempInfo: [DayTempInfo] = []
    
    var text: String = ""
    var text1: String = ""
    var feltTempToDay = Double()
    var feltTempYesterDay = Double()
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
    
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    
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
    
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
    if !tempInfo.isEmpty {
        
        if index == 0 {
            text = ""
            ///
            /// Legger inn temperaturen akkurat nå:
            ///
            text = text + String(localized: "Now it is ")
            text = text + "\(FormatDateToString(date: Date().adding(seconds: offsetSec), format: ("EEEE d. MMMM HH:mm"), offsetSec: 0))" + String(localized: " with ")
            text = text + "\(Int(tempInfo[tempType].data[IndexPointMarkFromHour(offsetSec: offsetSec)].temp.rounded()))" + "º"
            text = text + String(localized: " and ")
            text = text + tempInfo[tempType].data[IndexPointMarkFromHour(offsetSec: offsetSec)].condition.firstLowercased
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
            /// Legger inn høyeste vindkast:
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
            text = ""
            text = text + String(localized: "The lowest temperature on ")
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
            text = text + ".\n"
            text = text + String(localized: "The highest felt temperature ")
            text = text + "\(Int(maxAppearentTemp.rounded()))"
            text = text + "º"
            text = text + String(localized: " kl. ")
            text = text + IndexToHour(index: indexMaxAppearentTemp)
            text = text + "."
        }
        ///
        /// Finner følt temperatur i dag og i går:
        ///
        toDay = date
        toMorrow = toDay.adding(days: 1)
        yesterDay = toDay.adding(days: -1)
        arrayToDay.removeAll()
        arrayYesterDay.removeAll()
        hourForecast!.forEach  {
            if $0.date >= toDay &&
                $0.date < toMorrow {
                arrayToDay.append($0.apparentTemperature.value)
            }
        }
        hourForecast!.forEach  {
            if $0.date >= yesterDay &&
                $0.date < toDay {
                arrayYesterDay.append($0.apparentTemperature.value)
            }
        }
        ///
        /// Finner den høyest følte temperaturen i dag og i går
        ///
        feltTempToDay = arrayToDay.max()!
        feltTempYesterDay = arrayYesterDay.max()!
        
        if feltTempToDay > feltTempYesterDay {
            text1 = String(localized: "The felt temperature today is higher than yesterday.")
            factorToDay = 1.00
            factorYesterDay = 0.50
        } else if feltTempToDay == feltTempYesterDay {
            text1 = String(localized: "The felt temperature today is the same as yesterday.")
            factorToDay = 1.00
            factorYesterDay = 1.00
        } else {
            text1 = String(localized: "The felt temperature today is lower than yesterday.")
            factorToDay = 0.50
            factorYesterDay = 1.00
            
        }
    }
    return (text, text1, feltTempToDay, feltTempYesterDay, factorToDay, factorYesterDay)
}

private func TempInfoValues(tempInfo: [Temperature],
                            option : EnumType,
                            option1 : EnumType,
                            type: Int) -> (Double, Int, [DayTempInfo]) {
    
    /// option  = tempTemp, appearentTemp eller gustTemp
    /// option1 = min eller max
    
    @Environment(CurrentWeather.self) var currentWeather
    
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
    if !tempInfo.isEmpty {
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
                value = array.min() ?? 0.00
            } else if option1 == .max {
                value = array.max()!
            }
            ///
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
            ///
            /// Finn index til value:
            ///
            for i in 0..<array.count {
                if array[i] == value {
                    index = i
                    break
                }
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
