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
        WindowGroup {
            WeatherForecastMain()
                .environment(dateSettings)
                .environment(currentWeather)
                .environment(weatherInfo)
        }
    }
    func exitApp() {
        exit(0)
    }
}

