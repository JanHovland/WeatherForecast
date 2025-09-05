//
//  AverageprecipitationDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI
import Foundation
import Charts
 
struct AveragePrecipitationDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo

    @Environment(\.dismiss) var dismiss
    @State private var info: String = ""
    @State private var selectedIndex: Int?
    @State private var month: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        HStack (spacing: 0) {
                            if weatherInfo.normalDeviationPrecipitation > 0 {
                                Text("\(weatherInfo.normalDeviationPrecipitation)")
                                Text(String(localized: " mm more than usual."))
                            } else if weatherInfo.normalDeviationPrecipitation < 0 {
                                Text("\(abs(weatherInfo.normalDeviationPrecipitation))")
                                Text(String(localized: " mm less than usual."))
                            } else {
                                Text(String(localized: " as the normal."))
                            }
                            Spacer()
                        }
                        .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        HStack {
                            Text("\(String(localized: "Average over 30 days: ")) \(String(format: "%.0f", round(weatherInfo.precipitationNormalLast30Days ?? 0.00))) mm")
                                .fontWeight(.bold)
                                .opacity(0.50)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    ///
                    /// Chart over nedbøren de siste 30 dagene
                    ///
                    VStack {
                        Chart {
                            ForEach(weatherInfo.precipitation30DaysAccumulated) { data in
                                LineMark(
                                    x: .value("Index", data.index),
                                    y: .value("Precipitation", data.precipitation)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(by: .value("Type", "\(data.type)"))
                                .lineStyle(StrokeStyle(lineWidth: 2))
                            }
                            ForEach(weatherInfo.averagePrecipitationOverYears) { data in
                                LineMark(
                                    x: .value("IndexYears", data.index),
                                    y: .value("PrecipitationOverYears", data.precipitation)
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
                                        Text("\(weatherInfo.precipitation30DaysAccumulated[selectedIndex].precipitation, specifier: "%.0f") \("mm")")
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
                                    .offset(yStart: -12)
                                    .zIndex(-1)
                            }
                            ///
                            /// Markerer høyeste nedbørsverdi
                            ///
                            PointMark(x: .value("Index", 29),
                                      y: .value("Precipitation",
                                                weatherInfo.precipitation30DaysAccumulated[29].precipitation))
                            .symbol {
                                Image(systemName: "circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                            .annotation(position: .top) {
                                let v = Int(weatherInfo.precipitation30DaysAccumulated[29].precipitation)
                                Text("\(v) mm")
                                    .font(.footnote)
                                    .offset(x: -10)
                                    .foregroundColor(.green)
                            }
                            PointMark(x: .value("IndexYears", 29),
                                      y: .value("PrecipitationOverYears",
                                                weatherInfo.averagePrecipitationOverYears[29].precipitation))
                            .symbol {
                                Image(systemName: "circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                            }
                            .annotation(position: .top) {
                                let v = Int(weatherInfo.averagePrecipitationOverYears[29].precipitation)
                                Text("\(v) mm")
                                    .font(.footnote)
                                    .offset(x: -10)
                                    .foregroundColor(.orange)
                            }
                        }
                        .frame(maxWidth: .infinity,
                               minHeight: UIDevice.isIpad ? 350 : 200,
                               maxHeight: UIDevice.isIpad ? 400 : 350)
                        ///
                        /// https://developer.apple.com/documentation/charts/customizing-axes-in-swift-charts
                        ///
                        .chartXScale(domain: 0...29)
                        .chartYAxisLabel(ShowUnit(option: .precipitation),
                                         position: .top,
                                         spacing: 6)
                        .chartXSelection(value: $selectedIndex)

                    }
                    ///
                    /// Her overstyres fargen på linjene
                    ///
                    .chartForegroundStyleScale(range: [.green, .orange])
                    ///
                    ///Her kan det legges inn et eller flere "legend" (beskrivelser)
                    ///
                    .chartLegend(position: .bottom, alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading) {
                            HStack (spacing: 0) {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                                Text(String(localized: " Development of the rainfall from "))
                                    .foregroundStyle(.white)
                                let t = String(localized: "to")
                                let u = ConvertDate(date: weatherInfo.precipitation30DaysAccumulated[0].date)
                                let v = ConvertDate(date: weatherInfo.precipitation30DaysAccumulated[29].date)
                                Text("\(u) \(t) \(v)")
                                    .foregroundStyle(.white)
                            }
                            ///
                            /// Legg inn gjennomsnitlig ned gjennom årene
                            ///
                            HStack (spacing: 0) {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.orange)
                                Text(String(localized: " The normal rainfall from "))
                                    .foregroundStyle(.white)
                                let t = String(localized: "to")
                                let u = ConvertDate(date: weatherInfo.precipitation30DaysAccumulated[0].date)
                                let v = ConvertDate(date: weatherInfo.precipitation30DaysAccumulated[29].date)
                                Text("\(u) \(t) \(v)")
                                    .foregroundStyle(.white)
                            }

                        }
                        .font(.footnote)
                        .padding(.bottom, 10)
                    }
                    HStack {
                        Text(String(localized: "Overview"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    ///
                    /// Viser info
                    ///
                    HStack {
                        Text(info)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    ///
                    /// Viser normal månedlig nedbør
                    ///
                    HStack {
                        Text(String(localized: "Monthly average"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    HStack {
                        let a = String(localized: "Normal precification value for")
                        ///
                        /// Måneden
                        ///
                        let b = "\(weatherInfo.averageNormalPrecipitationMonth[month].month.firstLowercased)"
                        let c = String(localized: "is")
                        ///
                        /// Nedbørsmengde
                        ///
                        let d = "\(weatherInfo.averageNormalPrecipitationMonth[month].max)"
                        Text(String("\(a) \(b) \(c) \(d) mm."))
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    ///
                    /// Viser Chart for månedlig nedbør
                    ///
                    VStack {
                        AveragePrecificationNormalMonthView()
                    }
                    HStack {
                        Text(String(localized: "About normal rainfall"))
                            .font(.system(size: UIDevice.isIpad ? 30 : 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)

                    let e = String(localized: "Normal rainfall is based on rainfall measurements since")
                    let f = weatherInfo.startYear
                    let g = String(localized: "When the precipitation falls as snow, the normal amount of precipitation is calculated based on the equivalent amount of liquid if the snow were melted into water, and not the snow depth.")
                    HStack {
                        Text("\(e) \(f). \n\(g)")
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
            ///
            /// Finner aktuell måned
            ///
            month = Int(FormatDateToString(date:  GetLocalDate(date: Date()), format: "MM", offsetSec: 0)) ?? 0

            if month > 0 {
                month -= 1
            }
            ///
            /// Finner 30 dagers perioden
            ///
            ///
            /// Finner fromDate som er dagen i dag minus 1 dag
            ///
            let yesterDay = GetLocalDate(date: Date()).adding(days: -1)
            let dayTo = FormatDateToString(date: yesterDay, format: "d. MMMM", offsetSec: 0)
            ///
            /// Finner fromDate som er 30 dager bakover i tid
            ///
            let fromDate = yesterDay.adding(days: -30)
            let dayFrom = FormatDateToString(date: fromDate, format: "d. MMMM", offsetSec: 0)
            info = String(localized: "Normally it falls")
            info = info + String(format: "%.0f", round(weatherInfo.precipitationNormalLast30Days ?? 0.00)) + " mm "
            info = info + String(localized: "precipitation from ")
            info = info + dayFrom
            info = info + String(localized: " to ")
            info = info + dayTo
            info = info + ". "
            info = info + String(localized: "In the last 30 days, the total has fallen ")
            info = info + String(format: "%.0f", round(weatherInfo.precipitationLast30Days ?? 0.00)) + " mm."
        }
    }
}

