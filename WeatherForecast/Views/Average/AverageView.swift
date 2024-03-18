//
//  AverageView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import WeatherKit

struct AverageView : View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @State private var isModal: Bool = false
    
    var body: some View {
        VStack {
                HStack {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .symbolRenderingMode(.multicolor)
                        .font(Font.headline.weight(.regular))
                    Text("AVERAGES")
                        .font(.system(size: 15, weight: .bold))
                    Spacer()
                }
                .opacity(0.50)
                ZStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Information") {
                            self.isModal = true
                        }
                        .padding(7)
                        .foregroundColor(.primary)
                        .buttonStyle(.bordered)
                        .sheet(isPresented: $isModal, content: {
                            AverageDetailView()
                        })
                    }
                }
                .offset(y: -40)
                VStack {
                    Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                    //                        .font(.system(size: 40, weight: .light))
                    Text("\(averageMonthPrecification[0])")
                }
            Spacer()
        }

        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
