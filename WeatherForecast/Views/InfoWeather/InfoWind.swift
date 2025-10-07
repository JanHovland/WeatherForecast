//
//  InfoWind.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI

struct InfoWind : View {

    var index: Int
    var option: EnumType
    @Binding var dayArray : [Double]
    @Binding var windInfo : [WindInfo]
    @Binding var weekdayArray: [String]

    @State private var text : String = String(localized: "The wind speed is calculated based on the average over a short period of time. Gusts are sudden changes in wind strength above the average speed. A gust usually lasts less than 20 seconds.")
    @State private var text1 : String = ""
    @State private var text2 : String = ""
    @State private var text3: String = String(localized: "The Beaufort wind scale expresses how strongly the wind blows at a certain speed. The Beaufort scale can make it easier to understand how much wind is reported, and what effect it can have. Each value on the scale corresponds to a wind speed.")
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(ScreenSize.self) private var screenSize
    
    @State private var windToDay: Double = 10.00
    @State private var windYesterDay: Double = 20.00
    @State private var factorToDay: Double = 0.50
    @State private var factorYesterDay: Double = 1.00
    
    @State private var beaufort: [Beaufort] = Array(repeating: Beaufort(), count: sizeArray13)
    
    var body: some View {
        VStack (alignment: .leading) {

            Text(String(localized: "Daily overview"))
                .fontWeight(.bold)

            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            ///
            ///  Dagsforskjeller:
            ///
            if index == 0 {
                Text("Day differences")
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
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
                    .progressViewStyle(ProgressViewStyleModifier(progressWidth: CGFloat(UIDevice.isIpad ? screenSize.screenWidth * 0.825 : screenSize.screenWidth * 0.70),
                                                                 option: option,
                                                                 valueToDay: windToDay,
                                                                 valueYesterDay: windYesterDay,
                                                                 factorToDay: factorToDay,
                                                                 factorYesterDay: factorYesterDay))
            }
            ///
            /// Om vinden
            ///
            Text(String(localized: "About wind speed and gusts"))
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 20)

            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            ///
            /// Overskrift Beaufort skalaen
            ///
            Text("Beaufort-scale")
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
            ///
            /// Beskrivelse av Beaufort skalaen
            ///
            VStack(alignment: .leading) {
                HStack {
                    HStack {
                        Text("bft")
                        Spacer()
                    }
                    HStack {
                        Text("Description")
                        Spacer()
                    }
                    HStack {
                        Text("m/s")
                        Spacer()
                    }
                }
                ForEach(beaufort) { bf in
                    HStack {
                        HStack (spacing: 10) {
                            Image(bf.image)
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("\(bf.value)")
                            Spacer()
                        }
                        HStack {
                            Text(bf.description)
                            Spacer()
                        }
                        HStack {
                            Text(bf.range)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
            .font(.callout)
            .background(.background)
            ///
            /// Overskrift om Beaufort skalaen
            ///
            Text("About the Beaufort-scale")
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .padding(.top, 20)
            ///
            /// Om Beaufort skalaen
            ///
            TextField("", text: $text3, axis: .vertical)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)

            Spacer()
        }
        ///
        /// Legg merke til maxHeight ikke må begrense scrollimg, så legg inn en stor verdi.
        ///
        .frame(maxWidth: .infinity,
               maxHeight: 3000)
        .padding(15)
        .task {
            ///
            /// Bygger opp beaufort:
            ///
            
            beaufort.removeAll()
            
            let bft0 =  Beaufort(id: UUID(), image: "Beaufort 0",  value: 0,  description: "Stille",       range: "< 0,5")
            let bft1 =  Beaufort(id: UUID(), image: "Beaufort 1",  value: 1,  description: "Flau vind",    range: "0,5 - 1,5")
            let bft2 =  Beaufort(id: UUID(), image: "Beaufort 2",  value: 2,  description: "Svak vind",    range: "1,6 - 3,2")
            let bft3 =  Beaufort(id: UUID(), image: "Beaufort 3",  value: 3,  description: "Lett bris",    range: "3,3 - 5,4")
            let bft4 =  Beaufort(id: UUID(), image: "Beaufort 4",  value: 4,  description: "Laber bris",   range: "5,5 - 7.9")
            let bft5 =  Beaufort(id: UUID(), image: "Beaufort 5",  value: 5,  description: "Frisk bris",   range: "8,0 - 10,7")
            let bft6 =  Beaufort(id: UUID(), image: "Beaufort 6",  value: 6,  description: "Liten kuling", range: "10,8 - 13,8")
            let bft7 =  Beaufort(id: UUID(), image: "Beaufort 7",  value: 7,  description: "Stiv kuling",  range: "13,9 - 17,1")
            let bft8 =  Beaufort(id: UUID(), image: "Beaufort 8",  value: 8,  description: "Sterk kuling", range: "17,2 - 20,7")
            let bft9 =  Beaufort(id: UUID(), image: "Beaufort 9",  value: 9,  description: "Liten storm",  range: "20.8 - 24,4")
            let bft10 = Beaufort(id: UUID(), image: "Beaufort 10", value: 10, description: "Full storm",   range: "24,5 - 28,4")
            let bft11 = Beaufort(id: UUID(), image: "Beaufort 11", value: 11, description: "Sterk storm",  range: "28,5 - 32,6")
            let bft12 = Beaufort(id: UUID(), image: "Beaufort 12", value: 12, description: "Orkan",        range: "> 32,7")

            beaufort.append(bft0)
            beaufort.append(bft1)
            beaufort.append(bft2)
            beaufort.append(bft3)
            beaufort.append(bft4)
            beaufort.append(bft5)
            beaufort.append(bft6)
            beaufort.append(bft7)
            beaufort.append(bft8)
            beaufort.append(bft9)
            beaufort.append(bft10)
            beaufort.append(bft11)
            beaufort.append(bft12)
            ///
            /// Bygger opp værmeldingen:
            ///
            (text1, text2, windToDay, windYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                       dayArray: dayArray,
                                                                                       weekdayArray: weekdayArray,
                                                                                       windInfo: windInfo,
                                                                                       date: currentWeather.date,
                             offsetSec: weatherInfo.offsetSec)
        }
        .onChange(of: index) { oldIndex, index in
            ///
            /// Bygger opp værmeldingen:
            ///
            (text1, text2, windToDay, windYesterDay, factorToDay, factorYesterDay) = Forecast(index: index,
                                                                                              dayArray: dayArray,
                                                                                              weekdayArray: weekdayArray,
                                                                                              windInfo: windInfo,
                                                                                              date: currentWeather.date,
                                                                                              offsetSec: weatherInfo.offsetSec)
        }
    }
}

/// Bygger opp værmeldingen:
///

private func Forecast(index: Int,
                      dayArray: [Double],
                      weekdayArray: [String],
                      windInfo: [WindInfo],
                      date: Date,
                      offsetSec: Int) -> (String, String, Double, Double, Double, Double) {

    var text : String = ""
    var text1 : String = ""
    var weekDay: String = ""
    var toDay = Date()
    var toMorrow = Date()
    var yesterDay = Date()
    
    var windToDay: Double = 0.00
    var windYesterDay: Double = 0.00
    var factorToDay: Double = 1.00
    var factorYesterDay: Double = 1.00
    
    var arrayToDay: [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayYesterDay: [Double] = Array(repeating: Double(), count: sizeArray24)

    let minWindSpeed  = WindInfoValues(windInfo: windInfo,
                                       option: .windSpeed,
                                       option1: .min)

    let maxWindSpeed  = WindInfoValues(windInfo: windInfo,
                                       option: .windSpeed,
                                       option1: .max)

    let maxGustSpeed  = WindInfoValues(windInfo: windInfo,
                                       option: .gustSpeed,
                                       option1: .max)
    
    if index == 0 {
        text = String(localized: "Now it is ")
        text = text + "\(FormatDateToString(date: date, format: ("EEEE d. MMMM HH:mm"), offsetSec: offsetSec))"
        text = text + String(localized: " and the wind is now blowing")
        /// Legger inn vindstyrken nå :
        ///
        text = text + " \(Int(windInfo[windType].data[IndexPointMarkFromHour(offsetSec: offsetSec)].amount.rounded()))" + " m/s"
        /// Legger inn vindretningen :
        ///
        text = text + String(localized: " from")
        text = text + WindDirection(windInfo: windInfo,
                                    option: .longDirection,
                                    offsetSec: offsetSec)
        text = text + "."
        text = text + String(localized: " To day it will blow from ")
        text = text + "\(Int(minWindSpeed.rounded()))"
        text = text + String(localized: " to ")
        text = text + "\(Int(maxWindSpeed.rounded()))"
        text = text + " m/s"
        /// Legger inn vindkast :
        ///
        text = text + String(localized: " with gust up to ")
        text = text + "\(Int(maxGustSpeed.rounded()))"
        text = text + " m/s."
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " it will be blowing from ")
        /// Legger inn vindstyrken:
        ///
        text = text + "\(Int(minWindSpeed.rounded()))"
        text = text + String(localized: " to ")
        text = text + "\(Int(maxWindSpeed.rounded()))"
        text = text + " m/s"
        /// Legger inn vindkast :
        ///
        text = text + String(localized: " with gust up to ")
        text = text + "\(Int(maxGustSpeed.rounded()))"
        text = text + " m/s."
    }
    ///
    /// Finner vindstyrke i dag og i går:
    ///
    toDay = date.setTime(hour: 0, min: 0, sec: 0)!
    toMorrow = toDay.adding(days: 1)
    yesterDay = toDay.adding(days: -1)
    
    
    print("toDay = \(toDay)")               // 2025-10-07 00:00:00 +0000
    print("toMorrow = \(toMorrow)")         // 2025-10-08 00:00:00 +0000
    print("yesterDay = \(yesterDay)")       // 2025-10-06 00:00:00 +0000
 
    
    arrayToDay.removeAll()
    arrayYesterDay.removeAll()
    hourForecast!.forEach  {
        if $0.date >= toDay &&
            $0.date < toMorrow {
            ///
            /// km/h
            ///
            arrayToDay.append($0.wind.speed.value)
        }
    }
    hourForecast!.forEach  {
        if $0.date >= yesterDay &&
            $0.date < toDay {
            ///
            /// km/h
            ///
            arrayYesterDay.append($0.wind.speed.value)
        }
    }
    ///
    /// Finner den høyeste følt emperatur i dag og i går
    ///
    windToDay = arrayToDay.max()! * 1000 / 3600
    windYesterDay = arrayYesterDay.max()! * 1000 / 3600
    
    if windToDay > windYesterDay {
        text1 = String(localized: "The highest wind speed today is higher than yesterday.")
        factorToDay = 1
        factorYesterDay = windYesterDay / windToDay
    } else if windToDay == windYesterDay {
        text1 = String(localized: "The highest wind speed today is the same as yesterday.")
        factorToDay = 1.00
        factorYesterDay = 1.00
    } else {
        text1 = String(localized: "The highest wind speed today is lower than yesterday.")
        factorToDay = windToDay / windYesterDay
        factorYesterDay = 1
    }

    return (text, text1, windToDay, windYesterDay, factorToDay, factorYesterDay)
}

private func WindInfoValues(windInfo: [WindInfo], option : EnumType, option1 : EnumType) -> Double {

    /// option  = windSpeed eller gustSpeed
    /// option1 = min eller max

    var value : Double = 0.00
    var array : [Double] = []

    array.removeAll()

    if option == .windSpeed {
        for i in 0..<windInfo[windType].data.count {
            array.append(windInfo[windType].data[i].amount)
        }
    }
    
    if option == .gustSpeed {
        for i in 0..<windInfo[gustType].data.count {
            array.append(windInfo[gustType].data[i].amount)
        }
    }

    if option1 == .min {
        value = array.min()!
    } else if option1 == .max {
        value = array.max()!
    }

    return value
}

private func WindDirection(windInfo: [WindInfo], option: EnumType, offsetSec: Int) -> String {
    var direction : String = ""
    var deg : Double = 0.00

    deg = windInfo[0].data[IndexPointMarkFromHour(offsetSec: offsetSec)].direction

    direction = ""

    if option == .shortDirection {
        if deg < 11.25 || deg > 348.75 {
            direction = String(localized: "N")
        } else if deg < 22.50 {
            direction =  String(localized: "NNE")
        } else if deg < 67.5 {
            direction =  String(localized: "ENE")
        } else if deg < 90.0 {
            direction =  String(localized: "E")
        } else if deg < 112.5 {
            direction =  String(localized: "ESE")
        } else if deg < 135.00 {
            direction =  String(localized: "SE")
        } else if deg < 157.5 {
            direction =  String(localized: "SSE")
        } else if deg < 180.00 {
            direction =  String(localized: "S")
        } else if deg < 202.50 {
            direction =  String(localized: "SSW")
        } else if deg < 225.00 {
            direction =  String(localized: "SW")
        } else if deg < 247.50 {
            direction =  String(localized: "WSW")
        } else if deg < 270.00 {
            direction =  String(localized: "W")
        } else if deg < 292.50 {
            direction =  String(localized: "WNW")
        } else if deg < 315.00 {
            direction =  String(localized: "NW")
        } else {
            direction =  String(localized: "NNW")
        }
    } else if option == .longDirection {
        if deg < 11.25 || deg > 348.75 {
            direction = String(localized: "north")
        } else if deg < 22.50 {
            direction =  String(localized: "north-northeast")
        } else if deg < 67.5 {
            direction =  String(localized: "east-northeast")
        } else if deg < 90.0 {
            direction =  String(localized: "east")
        } else if deg < 112.5 {
            direction =  String(localized: "east-southeast")
        } else if deg < 135.00 {
            direction =  String(localized: "southeast")
        } else if deg < 157.5 {
            direction =  String(localized: "south-southeast")
        } else if deg < 180.00 {
            direction =  String(localized: "south")
        } else if deg < 202.50 {
            direction =  String(localized: "south-southwest")
        } else if deg < 225.00 {
            direction =  String(localized: "southwest")
        } else if deg < 247.50 {
            direction =  String(localized: "west-southwest")
        } else if deg < 270.00 {
            direction =  String(localized: "west")
        } else if deg < 292.50 {
            direction =  String(localized: "west-northwest")
        } else if deg < 315.00 {
            direction =  String(localized: "northwest")
        } else {
            direction =  String(localized: "north-northwest")
        }    }

    return direction

}

/*
 
 
 Forkortelse    Beskrivelse     Min.        Middel      Maks.
 
 N              nord            348,75      0           11,25
 NNØ            nord-nordøst    11,25       22,5        33,75
 ØNØ            øst-nordøst     56,25       67,5        78,75
 Ø              øst             78,75       90          101,25
 ØSØ            øst-sørøst      101,25      112,5       123,75
 SØ             sørøst          123,75      135         146,25
 SSØ            sør-sørøst      146,25      157,5       168,75
 S              sør             168,75      180         191,25
 SSV            sør-sørvest     191,25      202,5       213,75
 SV             sørvest         213,75      225         236,25
 VSV            vest-sørvest    236,25      247,5       258,75
 V              vest            258,75      270         281,25
 VNV            vest-nordvest   281,25      292,5       303,75
 NV             nordvest        303,75      315         326,25
 NNV            nord-nordvest   326,25      337,5       348,75


 
 */
