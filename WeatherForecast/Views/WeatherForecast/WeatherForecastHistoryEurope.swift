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
        VStack (alignment: .center, spacing: 0) {
            Text("Geosatellite")
            VideoPlayer(player: player)
                .frame(height: 455)
        }
        Spacer()
    }
}
