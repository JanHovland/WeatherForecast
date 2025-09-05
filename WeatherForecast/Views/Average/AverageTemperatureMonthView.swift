//
//  AverageTemperatureMonthView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/04/2024.
//

import SwiftUI
import Charts

/// https://swdevnotes.com/swift/2022/create-a-bar-chart-with-swiftui-charts-in-ios-16/

struct AverageTemperatureMonthView: View {

    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var averageTemperatureMonthArray: [AverageTemperatureMonth] = []
    @State private var space: String = " "
    
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                ///
                /// Venstre del
                ///
                Chart(averageTemperatureMonthArray) {
                    let mont = String($0.month) + space + String($0.min)
                    BarMark(
                        x: .value("Month", 0),
                        y: .value("Value", mont)
                    )
                    .annotation(position: .overlay, alignment: .leading, spacing: 3) {
                        Text("\(mont)º")
                            .font(.body).monospaced()
                    }
                }
                .frame(width: 150)
                .offset(x: -70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                ///
                /// Hoved delen
                ///
                Chart(averageTemperatureMonthArray) {
                    BarMark(
                        ///
                        /// Her benyttes yStart og yEnd
                        ///
                        xStart: .value("Start", $0.min),
                        xEnd: .value("Stop", $0.max),
                        y: .value("Month", $0.month)
                    )
                    .cornerRadius(7.5)
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                ///
                /// Høyre del
                ///
                Chart(averageTemperatureMonthArray) {
                    let value = $0.value
                    BarMark(
                        x: .value("Value0", 0),
                        y: .value("Value", $0.value)
                    )
                    .annotation(position: .overlay, alignment: .center, spacing: 3) {
                        Text("\(Double(value) ?? 0.00, specifier: "%.0F")º")
                    }
                }
                .offset(x: UIDevice.isIpad ? 20 : 15)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
            }
            .frame(minHeight: 400)
            .padding(.leading,  UIDevice.isIpad ? 75 : 0)
        }
        .onAppear {
            var a: AverageTemperatureMonth = AverageTemperatureMonth(id: UUID(),
                                                                     month: "",
                                                                     min: 0,
                                                                     max: 0,
                                                                     value: "")
            var counter: Double = 0.00
            var value: Double = 0.00
            
            averageTemperatureMonthArray.removeAll()
            
            a.month = String(localized: "Jan")
            a.min = weatherInfo.normalJanuaryMin
            a.max = weatherInfo.normalJanuaryMax
            value = Double(weatherInfo.normalJanuaryMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Feb")
            a.min = weatherInfo.normalFebruaryMin
            a.max = weatherInfo.normalFebruaryMax
            value = Double(weatherInfo.normalFebruaryMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Mar")
            a.min = weatherInfo.normalMarsMin
            a.max = weatherInfo.normalMarsMax
            value = Double(weatherInfo.normalMarsMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Apr")
            a.min = weatherInfo.normalAprilMin
            a.max = weatherInfo.normalAprilMax
            value = Double(weatherInfo.normalAprilMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "May")
            a.min = weatherInfo.normalMayMin
            a.max = weatherInfo.normalMayMax
            value = Double(weatherInfo.normalMayMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Jun")
            a.min = weatherInfo.normalJuneMin
            a.max = weatherInfo.normalJuneMax
            value = Double(weatherInfo.normalJuneMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Jul")
            a.min = weatherInfo.normalJulyMin
            a.max = weatherInfo.normalJulyMax
            value = Double(weatherInfo.normalJulyMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Aug")
            a.min = weatherInfo.normalAugustMin
            a.max = weatherInfo.normalAugustMax
            value = Double(weatherInfo.normalAugustMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Sep")
            a.min = weatherInfo.normalSeptemberMin
            a.max = weatherInfo.normalSeptemberMax
            value = Double(weatherInfo.normalSeptemberMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Oct")
            a.min = weatherInfo.normalOctoberMin
            a.max = weatherInfo.normalOctoberMax
            value = Double(weatherInfo.normalOctoberMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Nov")
            a.min = weatherInfo.normalNovemberMin
            a.max = weatherInfo.normalNovemberMax
            value = Double(weatherInfo.normalNovemberMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
           
            counter += 0.01
            a.month = String(localized: "Dec")
            a.min = weatherInfo.normalDecemberMin
            a.max = weatherInfo.normalDecemberMax
            value = Double(weatherInfo.normalDecemberMax) + counter
            a.value = "\(value)"
            averageTemperatureMonthArray.append(a)
        }
    }
}
