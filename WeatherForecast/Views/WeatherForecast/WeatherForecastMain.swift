//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI

/// Definerer globale variabler:
///

var windType: Int = 0
var gustType: Int = 1

var tempType: Int = 0
var appearentType: Int = 1

var uvIconType: Int = 0
var windIconType: Int = 1
var humidityIconType: Int = 2
var visibilityIconType: Int = 3
var airpressureIconType: Int = 4

///
/// Oppretter latitude og lonfitude som globale varabler:
///

var latitude: Double?
var longitude: Double?

private var sidebar: some View {
    /// Ipad:
    ///
    NavigationView {
        List {
            NavigationLink(destination: WeatherForecast()) {
                Label("WeatherForecast", systemImage: "cloud.sun.rain.fill")
            }
            NavigationLink(destination: SettingView()) {
                Label("Setting", systemImage: "gear")
            }
            NavigationLink(destination: ToDoView()) {
                Label("To do", systemImage: "list.bullet")
            }
        }
        WeatherForecast()
    }
}

private var tabview: some View {
    /// iPhone;
    ///
    TabView {
        WeatherForecast()
            .tabItem {
                Label("WeatherForecast", systemImage: "cloud.sun.rain.fill")
            }
        SettingView()
            .tabItem {
                Label("Setting", systemImage: "gear")
            }
        ToDoView()
            .tabItem {
                Label("To do", systemImage: "list.bullet")
            }
    }
}

struct WeatherForecastMain: View {
    
   /// Finner aktuell enhet:
    ///
    var body: some View {
        if UIDevice.isIpad {
            sidebar
                .task {
                    ///
                    /// Finn latitude og longitude ved oppstart:
                    ///
                    latitude = nil              // 58.61730433715967     Varhaug
                    longitude = nil             //  5.644919460720766    Varhaug
                }
        } else {
            tabview
                .task {
                    ///
                    /// Finn latitude og longitude ved oppstart:
                    ///
                    latitude = nil              // 58.61730433715967     Varhaug
                    longitude = nil             //  5.644919460720766    Varhaug
                }
        }
    }
    
}
