//
//  AverageFirstView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI

struct AverageFirstView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
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
                .padding(.bottom, 10)
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
        .onTapGesture {
            isTemperature.toggle()
        }
        .sheet(isPresented: $isTemperature, content: {
            AverageView()
                .background(Color("Background#01").opacity(currentWeather.isDaylight == true ? 0.60 : 0.35))
        })
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        .onAppear {
            logger.notice("Data.time = \(averageDataRecord.time)")
            
            let v = FindPrecipitationLast30Days(averageDataRecord: averageDataRecord,
                                                offset: weatherInfo.offsetSec)
            
            logger.notice("Precification last 30 days = \(v)")
        }

    }
}
