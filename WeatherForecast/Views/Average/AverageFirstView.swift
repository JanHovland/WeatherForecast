//
//  AverageFirstView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI

struct AverageFirstView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @State private var isTemperature: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("AVERAGES")
                Spacer()
            }
            Text("+3º")
                .font(.system(size: 40, weight: .light))
            Text(String(localized: "above the normal highest daytime temperature."))
            HStack {
                HStack {
                    Text(String(localized: "Today"))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("H: 8º")
                }
            }
            HStack {
                HStack {
                    Text(String(localized: "Average"))
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("H: 5º")
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .background(
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .fill(Color(.lightGray).opacity(0.40))
        )
        .onTapGesture {
            isTemperature.toggle()
        }
        .sheet(isPresented: $isTemperature, content: {
            AverageView()
        })
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
