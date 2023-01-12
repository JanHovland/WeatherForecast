//
//  SettingView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Key for OpenCage")) {
                    TextField("Key for OpenCage", text: $userSettings.keyOpenCage)
                        .font(.footnote)
                }
                Section(header: Text("Url for OpenCage")) {
                    TextField("Url for OpenCage", text: $userSettings.urlOpenCage)
                        .font(.footnote)
                }
                Section(header: Text("Key for OpenWeatherMap")) {
                    TextField("Key for OpenWeatherMap", text: $userSettings.keyOpenWeatherMap)
                        .font(.footnote)
                }
                Section(header: Text("Url1 for OpenWeatherMap")) {
                    TextField("Url1 for OpenWeatherMap", text: $userSettings.urlOpenWeatherMap1)
                        .font(.footnote)
                }
                Section(header: Text("Url2 for OpenWeatherMap")) {
                    TextField("Url2 for OpenWeatherMap", text: $userSettings.urlOpenWeatherMap2)
                        .font(.footnote)
                }
                Section(header: Text("Url for Met.no")) {
                    TextField("Url for Met.no", text: $userSettings.urlMetNo)
                        .font(.footnote)
                }
            }
        }
        .navigationTitle("Setting")
    }
}

