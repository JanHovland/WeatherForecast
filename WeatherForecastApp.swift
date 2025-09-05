//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/07/2022.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    var body: some Scene {
        @State var dateSettings = DateSettings()
        @State var currentWeather = CurrentWeather()
        @State var weatherInfo = WeatherInfo()
        @State var screenSize = ScreenSize()
        WindowGroup {
            WeatherForecastMain()
                .environment(dateSettings)
                .environment(currentWeather)
                .environment(weatherInfo)
                .environment(screenSize)
        }
    }
    func exitApp() {
        exit(0)
    }
}

