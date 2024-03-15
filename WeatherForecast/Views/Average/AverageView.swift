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
            HStack {
                Spacer()
                Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                    .font(.system(size: 40, weight: .light))
                    .padding(.top, 10)
                Spacer()
            }
            Spacer()
        }
        .sheet(isPresented: $isModal, content: {
            AverageDetailView()
        })
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        ///
        /// Må plasseres helt på slutten for å kunne trykke på hele bildet og ikke bare på en tekst eller bilde
        ///
        .onTapGesture {
            logger.notice("onTapGesture")
            self.isModal = true
        }
     }
}
