//
//  ChartViewNewProbability.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2023.
//

import SwiftUI
import WeatherKit
import Charts

struct ChartViewNewProbability: View {
    let index: Int
    let newData: [NewProbability]
    let min: Double
    let minIndex: Int
    let max: Double
    let maxIndex: Int
    
    @State private var selectedIndex: Int?
    
    @State private var markColors : [Color] = [.blue, .cyan, .indigo, .primary, .orange]
    
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            Chart {
                ForEach(newData) {
                    LineMark (
                        x: .value("Hour", $0.hour),
                        y: .value("Value", $0.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(by: .value("Type", $0.type))
                    .lineStyle(StrokeStyle(lineWidth: 1))
                }
                if let selectedIndex {
                    RuleMark(x: .value("Hour", selectedIndex))
                        .annotation(
                            position: .top, spacing: 0,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            showSelectedValue
                        }
                        .foregroundStyle(Color.white.opacity(0.15))
                        .offset(yStart: UIDevice.isIpad ? -10 : -10) /// Viser verdien relativt til største verdi av "Value"
                        .zIndex(-1)
                }
                PointMark(x: .value("Hour", minIndex),
                          y: .value("Value", min))
                .symbol(.circle)
                .annotation(position: .top) {
                    if min > 0.00 {
                        Text("\(Int(min)) %")
                            .font(.footnote.weight(.bold))
                            .opacity(0.50)
                    }
                }
                PointMark(x: .value("Hour", maxIndex),
                          y: .value("Value", max))
                .symbol(.circle)
                .annotation(position: .top) {
                    Text("\(Int(max)) %")
                        .font(.footnote.weight(.bold))
                        .opacity(0.50)
                }
                ///
                /// Markerer den tidligere delen av dagen:
                ///
                RectangleMark (xStart: .value("Range Start", 0),
                               xEnd: .value("Range End", index == 0 ? currentWeather.hour : 0)
                )
                .foregroundStyle(.black.opacity(0.35))

            }
            .frame(width: UIDevice.isIpad ? 520 : 350, height: UIDevice.isIpad ? 150 : 200)
            .chartXScale(domain: 0...24)
            .chartForegroundStyleScale(range: markColors)
            .modifier(DayDetailChartYaxis(option: .probability, from: 0, to: 100))
            .chartYAxisLabel(ShowUnit(option: .probability),
                             position: .top,
                             spacing: 6)
            .chartXSelection(value: $selectedIndex)
        }
        .modifier(DayDetailChartOffsetViewModifier(option: .probability))
    }
    @ViewBuilder
    var showSelectedValue: some View {
        VStack(alignment: .leading) {
            if selectedIndex! < sizeArray24 {
                Text("\(newData[selectedIndex!].value, specifier: "%.0f") \(" %")")
            }
        }
        .fixedSize()
        .foregroundStyle(.primary)
        .padding(.horizontal, 7.5)
        .background {
            RoundedRectangle(cornerRadius: 7.5)
                .foregroundStyle(Color.blue.opacity(0.50))
        }
    }
}


