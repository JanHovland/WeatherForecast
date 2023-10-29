//
//  WeatherForecastHistoryEurope.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/04/2023.
//

import SwiftUI
import AVKit
import WeatherKit

/// https://medium.com/devtechie/playing-videos-in-swiftui-avkit-fd1ece1b0315

struct WeatherForecastHistoryEurope: View {
    let weather: Weather
    
    @State var player = AVPlayer(url: URL(string: "https://api.met.no/weatherapi/geosatellite/1.4/europe.mp4")!)

    var body: some View {
        VStack {
            Text("Geosatellite")
//                .font(.title3)
//                .padding(.top, 10)
            ZStack {
                VideoPlayer(player: player)
                    .frame(height: 455)
            }
            Spacer()
        }
        .frame(width: 790, height: 520)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}
