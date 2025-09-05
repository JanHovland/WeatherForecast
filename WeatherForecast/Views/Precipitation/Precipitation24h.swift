//
//  Precipitation24h.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 11/10/2022.
//

import SwiftUI
import WeatherKit
import MapKit

struct Precipitation24h : View {
    let weather: Weather
    
    @State private var Precipitation24hBackwards: String = ""
    @State private var Precipitation24hForwards: String = ""
    
    @Environment(WeatherInfo.self) private var weatherInfo

    var body: some View {
        VStack {
            /// Viser overskriften for regn de siste 24 timene:
            ///
            HStack {
                Image(systemName: "drop.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("PRECIPITATION")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            /// Viser regn de neste 24 timene:
            ///
            Text(Precipitation24hBackwards)
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -20)
            Text("Last 24 h")
                .padding(.top, -22)
                .padding(.leading, -45)
            /// Viser regn det neste døgn:
            ///
            let a = String(localized: "is expected the next day.")
            Text("\(Precipitation24hForwards) \(a)")
                .lineLimit(4)
                .padding(.leading, -21)
                .padding(.bottom, -20)
            Spacer()
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
        .task {
            var lat: Double = 0.00
            var lon: Double = 0.00
            /// Bruker location for Varhaug:
            ///
            if weatherInfo.latitude != nil {
                lat  = weatherInfo.latitude!
            }
            
            if weatherInfo.longitude != nil {
                lon = weatherInfo.longitude!
            }
            
            let location = CLLocation(latitude: lat,
                                      longitude: lon)
            
            let value: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                     location: location,
                                                                     option: .backward,
                                                                     offsetSec: weatherInfo.offsetSec)
            
            Precipitation24hBackwards = value.1
            
            let value1: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                      location: location,
                                                                      option: .forward,
                                                                      offsetSec: weatherInfo.offsetSec)
            
            Precipitation24hForwards = value1.1
            
        }
    }
}
