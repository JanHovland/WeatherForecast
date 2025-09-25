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
    @AppStorage("KeyWeatherApi") var keyWeatherApi = ""
    
    @AppStorage("UrlOpenCage") var urlOpenCage = ""
    @AppStorage("UrlOpenWeather") var urlOpenWeather = ""
    
    @AppStorage("UrlMetNo") var urlMetNo = ""
    @AppStorage("UrlWeatherApiMoon") var urlWeatherApiMoon = ""
    
    @AppStorage("UrlRestCountries") var urlRestCountries = ""
    
    @AppStorage("Url1OpenMeteo") var url1OpenMeteo = ""
    @AppStorage("Url2OpenMeteo") var url2OpenMeteo = ""
    
    @AppStorage("Use30Years") var use30Years = false
    
    @AppStorage("UrlRapidApi") var urlRapidApi = ""
    @AppStorage("KeyRapidApi") var keyRapidApi = ""
    @AppStorage("KeyRapidHost") var keyRapidHost = ""
    
    var body: some View {
        VStack {
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
                
                Section(header: Text("Key for WeatherApi")) {
                    TextField("Key for WeatherApi", text: $keyWeatherApi)
                        .font(.footnote)
                }
                
                Section(header: Text("Url for WeatherApi")) {
                    TextField("Url for WeatherApi moon", text: $urlWeatherApiMoon)
                        .font(.footnote)
                }
                
                Section(header: Text("Url for restcountries")) {
                    TextField("Url for restcountries", text: $urlRestCountries)
                        .font(.footnote)
                }
                
                Section(header: Text("Url1 OpenMeteo.com")) {
                    TextField("Url1 OpenMeteo.com", text: $url1OpenMeteo)
                        .font(.footnote)
                }
                
                Section(header: Text("Url2 OpenMeteo.com")) {
                    TextField("Url2 OpenMeteo.com", text: $url2OpenMeteo)
                        .font(.footnote)
                }
                
                Section(header: Text("USE 30 YEARS PERIODE")) {
                    Toggle("Use 30 years periode", isOn: $use30Years)
                        .font(.footnote)
                }
                
                Section(header: Text("Url RapidApi.com")) {
                    TextField("Url RapidApi.com", text: $urlRapidApi)
                        .font(.footnote)
                }
                
                Section(header: Text("Key for RapidApi")) {
                    TextField("Key for RapidApi", text: $keyRapidApi)
                        .font(.footnote)
                }
                
                Section(header: Text("Host for RapidApi")) {
                    TextField("Host for RapidApi", text: $keyRapidHost)
                        .font(.footnote)
                }
   
            }
            .keyboardType(.asciiCapable)
        }
        .navigationTitle("Setting")
        .scrollIndicators(.hidden)
    }
}

