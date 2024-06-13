//
//  WeatherForecastHistoryEurope.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 16/04/2023.
//

import SwiftUI
import WeatherKit
import SafariServices


/// https://medium.com/devtechie/playing-videos-in-swiftui-avkit-fd1ece1b0315

struct WeatherForecastHistoryEurope: View {

    @State private var showSafariView = false
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    var body: some View {
        VStack {
            Button(action: {
                showSafariView = true
            }) {
                Text("Open OpenWeatherMap")
                    .foregroundColor(.white)
                    .padding()
                    .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
            }
        }
        .fullScreenCover(isPresented: $showSafariView) {
            SafariView(url: URL(string: "https://openweathermap.org/weathermap?basemap=map&cities=false&layer=radar&lat=" + String(Double(weatherInfo.latitude ?? 0.00)) + "&lon=" + String(Double(weatherInfo.longitude ?? 0.00)) + "&zoom=5")!)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No need to update the view controller
    }
}
