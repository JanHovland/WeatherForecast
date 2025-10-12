//
//  AverageTemperatureDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation
import Charts

struct AverageTemperatureDetailView: View {
    
    
    /// https://www.devtechie.com/community/public/posts/154178-new-in-swiftui-4-multi-series-bar-chart
    
    /// https://blog.stackademic.com/barchart-using-swift-charts-swiftui-5e1db8068b46
    
    /// https://ishtiz.com/swiftui/acing-swiftui-chart
    /// https://www.danijelavrzan.com/posts/2023/10/combine-swift-charts/
    
    ///                            https://nilcoalescing.com/blog/BuildAndStyleAChartWithSwiftChartsFramework/
    ///                            https://nilcoalescing.com/blog/AreaChartWithADimmingLayer/
    ///                            https://swdevnotes.com/swift/2022/customise-a-line-chart-with-swiftui-charts-in-ios-16/
    ///                            https://developer.apple.com/documentation/charts/areamark
    ///                            https://stackoverflow.com/questions/72879128/how-to-label-axes-in-swift-charts

    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @Environment(\.dismiss) var dismiss
    @State private var info: String = ""
    @State private var selectedIndex: Int?
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 0) {
                        if weatherInfo.dailyDeviationTemp == 0 {
                            Text("As normal")
                        } else if weatherInfo.dailyDeviationTemp > 0 {
                            Text("\(String(describing: weatherInfo.dailyDeviationTemp))º")
                            Text(" over the normal")
                        } else if weatherInfo.dailyDeviationTemp < 0 {
                            Text("\(abs(weatherInfo.dailyDeviationTemp))º")
                            Text(" under the normal")
                        }
                        Spacer()
                    }
                    .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                    VStack {
                        let c = String(localized: "Normally the highest: ")
                        let d = String(format: "%.0f", round(weatherInfo.normalDailyHighTemp ?? 0.00))
                        HStack {
                            Text("\(c)\(d)º ")
                                .fontWeight(.bold)
                                .opacity(0.50)
                            Spacer()
                        }                        
                        .padding(.bottom, 10)
                        HStack {
                            Text("Today highest")
                                .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                            Spacer()
                        }
                        HStack {
                            Text("\(String(format: "%.0f", round(weatherInfo.highTemperature ?? 0.00)))º")
                            Spacer()
                        }
                        .opacity(0.50)
                        .padding(.bottom, 20)
                        
                    }
                    ///
                    /// Viser kurve over min, max og temperaturen denne dagen
                    ///
                    VStack {
                        Chart {
                            ForEach(weatherInfo.temperaturMinMaxArray) { data in
                                AreaMark(
                                    x: .value("Hour", data.hour),
                                    yStart: .value("TempLow", data.min),
                                    yEnd: .value("TempHigh",  data.max)
                                )
                                .foregroundStyle(.blue.opacity(0.4))
                            }
                            ForEach(weatherInfo.temperaturMinMaxArray) { data in
                                LineMark(
                                    x: .value("Hour", data.hour),
                                    y: .value("Temperature", data.temp)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(by: .value("Type", "\(data.type)"))
                                .lineStyle(StrokeStyle(lineWidth: 2))
                            }
                            if let selectedIndex {
                                RuleMark(x: .value("Value", selectedIndex))
                                    .annotation(
                                        position: .top, spacing: 0,
                                        overflowResolution: .init(
                                            x: .fit(to: .chart),
                                            y: .disabled
                                        )
                                    ) {
                                        Text("\(weatherInfo.temperaturMinMaxArray[selectedIndex].temp, specifier: "%.0f") \("º C")")
                                            .fixedSize()
                                            .foregroundStyle(.primary)
                                            .padding(.horizontal, 7.5)
                                            .background {
                                                RoundedRectangle(cornerRadius: 7.5)
                                                    .foregroundStyle(Color.blue.opacity(0.50))
                                            }
                                    }
                                    .foregroundStyle(Color.white.opacity(0.15))
                                    ///
                                    /// Viser verdien relativt til største verdi av "Value"
                                    ///
                                    .offset(yStart: UIDevice.isIpad ? -41 : -41)
                                    .zIndex(-1)
                            }
                            ///
                            /// Markerer høyeste temperatur
                            ///
                            PointMark(x: .value("Hour", weatherInfo.toDayAverageTemperatureMaxIndex),
                                      y: .value("Value",weatherInfo.toDayAverageTemperatureMaxValue))
                            .symbol {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                            .annotation(position: .top) {
                                Text("H")
                                    .font(.body.weight(.bold))
                            }
                            ///
                            /// Markerer den tidligere delen av dagen:
                            ///
                            RectangleMark (xStart: .value("Range Start", 0),
                                           xEnd: .value("Range End", currentWeather.hour)
                            )
                            .foregroundStyle(.black.opacity(0.15))
                        }
                        .frame(maxWidth: .infinity,
                               minHeight: UIDevice.isIpad ? 350 : 200,
                               maxHeight: UIDevice.isIpad ? 400 : 250)
                        .chartXScale(domain: 0...23)
                        .chartYAxisLabel(ShowUnit(option: .temperature),
                                         position: .top,
                                         spacing: 6)
                        .chartXSelection(value: $selectedIndex)
//                        .chartBackground { chartProxy in
//                            LinearGradient(colors: [Color.pink.opacity(1.0), Color.pink.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)
//                        }
                        
                        // https://swiftwithmajid.com/2023/02/22/mastering-charts-in-swiftui-legends/
                    }
                    ///
                    /// Her overstyres fargen på linjene
                    ///
                    .chartForegroundStyleScale(range: [.green, .orange])
                    ///
                    ///Her kan det legges inn et eller flere "legend" (beskrivelser)
                    ///
                    .chartLegend(position: .top, alignment: .leading, spacing: 0) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.green)
                            Text(String(localized: "Temperature"))
                                .foregroundStyle(.white)
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.blue.opacity(0.4))
                            Text(String(localized: "Normalarea"))
                                .foregroundStyle(.white)
                            let t = String(localized: "to")
                            let u =  Int(round(weatherInfo.temperaturMinMaxArrayAverageMinTemp ?? 0))
                            let v =  Int(round(weatherInfo.temperaturMinMaxArrayAverageMaxTemp ?? 0))
                            Text("(\(u)º \(t) \(v)º)")
                                .foregroundStyle(.white)
                        }
                        .font(.footnote)
                    }
                    HStack {
                        Text(String(localized: "Overview"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical)
                    HStack {
                        Text(info)
                        Spacer()
                    }
                    HStack {
                        Text(String(localized: "Monthly averages"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    let f = String(localized: "Lowest average temperature for ")
                    let from1 = FormatDateToString(date:  GetLocalDate(date: Date()), format: "MMMM", offsetSec: 0)
                    let g = from1
                    let h = String(localized: " is ")
                    let i = String(format: "%.0f", weatherInfo.normalMonthlyLowTemp ?? 0.00)
                    let j = String(localized: "and highest average temperature is ")
                    let k = String(format: "%.0f", weatherInfo.normalMonthlyHighTemp ?? 0.00)
                    HStack {
                        Text("\(f)\(g)\(h)\(i)º, \(j)\(k)º.")
                        Spacer()
                    }
                    ///
                    /// Viser min, max og månedsposisjon
                    ///
                    VStack {
                        AverageTemperatureMonthView()
                    }
                    
                    HStack {
                        Text(String(localized: "About the normal range"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    let u = String(localized: "The normal range shows the most common temperature measurements for")
                    let from2 = FormatDateToString(date:  GetLocalDate(date: Date()), format: "d. MMMM", offsetSec: 0)
                    let x = String(localized: "since")
                    let y = yearFromNormal10
                    HStack {
                        Text("\(u) \(from2) \(x) \(y).\n")
                        Spacer()
                    }
                    HStack {
                        Text(String(localized: "About normal temperatures"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    let l = String(localized: "Normally the highest temperature is based on the average temperature for ")
                    let o = String(localized: "every year since")
                    let p = weatherInfo.startYear
                    HStack {
                        Text("\(l)\(from2) \(o) \(p).")
                        Spacer()
                    }
                    let q = String(localized: "Monthly averages reflect the highest and lowest daily temperatures since")
                    let r = weatherInfo.startYear
                    let s = String(localized: "For example, the monthly average for January is based on measurements from 1 January to 31 January every year since")
                    let t = weatherInfo.startYear
                    HStack {
                        Text("\n\(q) \(r). \(s) \(t).")
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .onAppear {
            info = String(localized: "For ")
            ///
            /// Formatterer dato i dag
            ///
            let from = FormatDateToString(date:  GetLocalDate(date: Date()), format: "d. MMMM", offsetSec: 0)
            info = info + from + " "
            info = info + String(localized: "the normal temperature is in between ")
            info = info + String(format: "%.0f", weatherInfo.temperaturMinMaxArrayAverageMinTemp ?? 0.00)
            info = info + String(localized: "º and ")
            info = info + String(format: "%.0f", weatherInfo.temperaturMinMaxArrayAverageMaxTemp ?? 0.00)
            info = info + "º,"
            info = info + String(localized: " and normally the highest temperature is ")
            info = info + String(format: "%.0f", weatherInfo.normalDailyHighTemp ?? 0.00)
            info = info + String(localized: "º. Today's highest temperature is now ")
            info = info + String(format: "%.0f", weatherInfo.highTemperature ?? 0.00)
            info = info + "º."
        }
    }
    
    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.pink.opacity(0.8),
                    Color.pink.opacity(0.01),
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
