//
//  SettingView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI

struct SettingView: View {
    
    ///
    /// Bruker nå @AppStorage som igjen setter og henter data fra UserSettings
    /// 
    
    @AppStorage("KeyOpenCage") var keyOpenCage = ""
    @AppStorage("KeyOpenWeather") var keyOpenWeather = ""
    @AppStorage("UrlOpenCage") var urlOpenCage = ""
    @AppStorage("UrlOpenWeather") var urlOpenWeather = ""

    @AppStorage("UrlMetNo") var urlMetNo = ""
    @AppStorage("UrlMetMoonNo") var urlMetMoonNo = ""
    @AppStorage("ShowWeather") var showWeather = false

    var body: some View {
        VStack {
            HStack {
                Text("Setting")
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal, 30)
            Form {
                Section(header: Text("Key for OpenCage")) {
                    TextField("Key for OpenCage", text: $keyOpenCage)
                         .font(.footnote)
                }
                Section(header: Text("Url for OpenCage")) {
                    TextField("Url for OpenCage", text: $urlOpenCage)
                        .font(.footnote)
                }
                Section(header: Text("Key for OpenWeather")) {
                    TextField("Key for OpenWeather", text: $keyOpenWeather)
                        .font(.footnote)
                }
                Section(header: Text("Url for OpenWeather")) {
                    TextField("Url for OpenOpenWeather", text: $urlOpenWeather)
                        .font(.footnote)
                }
                Section(header: Text("Url for Met.no sun")) {
                    TextField("Url for Met.no", text: $urlMetNo)
                        .font(.footnote)
                }
                Section(header: Text("Url for Met.no moon")) {
                    TextField("Url for Met.no moon", text: $urlMetMoonNo)
                        .font(.footnote)
                }
                Section(header: Text("SHOW WEATHER FOR PLACES IN CLOUDKIT")) {
                    Toggle("Show weather for places in CloudKit", isOn: $showWeather)
                        .font(.footnote)
                }
            }
            .keyboardType(.asciiCapable)
        }
    }
}

