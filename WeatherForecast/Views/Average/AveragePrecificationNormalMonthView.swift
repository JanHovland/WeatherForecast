//
//  AveragePrecificationNormalMonthView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/05/2024.
//

import SwiftUI
import Charts

/// https://swdevnotes.com/swift/2022/create-a-bar-chart-with-swiftui-charts-in-ios-16/

struct AveragePrecificationNormalMonthView: View {

    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var averageNormalPrecipitationMonth: [AverageNormalPrecipitationMonth] = []
    @State private var space: String = " "
    
    var body: some View {
        VStack {
            HStack (spacing: UIDevice.isIpad ? 0 : -80) {
                ///
                /// Venstre del
                ///
                Chart(weatherInfo.averageNormalPrecipitationMonth) {
                    let mont = String($0.month)
                    BarMark(
                        x: .value("Month", 0),
                        y: .value("Value", mont)
                    )
                    .annotation(position: .overlay, alignment: .leading, spacing: 3) {
                        Text("\(mont)")
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
                Chart(weatherInfo.averageNormalPrecipitationMonth) {
                    BarMark(
                        ///
                        /// Her benyttes yStart og yEnd
                        ///
                        xStart: .value("Start", $0.min),
                        xEnd: .value("Stop", $0.max),
                        y: .value("Month", $0.month)
                    )
                    .cornerRadius(20)
                    .cornerRadius(20)
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                ///
                /// Høyre del
                ///
                Chart(weatherInfo.averageNormalPrecipitationMonth) {
                    let value = $0.value
                    let space = (Double(value) ?? 0.00 < 100.00 ? " " : "")
                    BarMark(
                        x: .value("Value0", 0),
                        y: .value("Value", $0.value)
                    )
                    .annotation(position: .overlay, alignment: .center, spacing: 3) {
                        Text("\(space)\(Double(value) ?? 0.00, specifier: "%.0F") mm")
                            .font(.body).monospaced()
                    }
                }
                .offset(x: 20)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
            }
            .frame(minHeight: 400)
            .padding(.leading,  UIDevice.isIpad ? 75 : 0)
        }
    }
}
