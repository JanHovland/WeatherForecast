//
//  MapDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2023.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    ///
    /// Må initialisere alle @State private var:_
    ///
    @State private var location = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    
    var body: some View {
        VStack {
            Map {
                Marker("", coordinate: location)
            }
            .frame(width: UIDevice.isIpad ? 765 : 370, height: UIDevice.isIpad ? 280 : 230)
            .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.foodMarket])))
        }
        .frame(width: UIDevice.isIpad ? 785 : 390, height: UIDevice.isIpad ? 300 : 250)
        .background(
            RoundedRectangle(cornerRadius: 15,
                             style: .continuous)
            .fill(Color("Background#01").opacity(currentWeather.isDaylight == true ? 0.85 : 0.35))
            .saturation(1)
        )
        .task {
            location = CLLocationCoordinate2D(latitude: weatherInfo.latitude ?? 0.00, longitude: weatherInfo.longitude ?? 0.00)
        }
    }
}

