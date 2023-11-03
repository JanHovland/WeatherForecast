//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/07/2022.
//

import SwiftUI
import TipKit

@main
struct WeatherForecastApp: App {
    init() {
        // Configure Tip's data container
        try? Tips.configure()
    }
    var body: some Scene {
        @State var dateSettings = DateSettings()
        @State var currentWeather = CurrentWeather()
        @State var weatherInfo = WeatherInfo()
        WindowGroup {
            WeatherForecastMain()
                .environment(dateSettings)
                .environment(currentWeather)
                .environment(weatherInfo)
        }
    }
}

