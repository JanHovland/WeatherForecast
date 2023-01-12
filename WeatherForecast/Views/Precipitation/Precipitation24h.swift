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

    var body: some View {
        VStack {
            /// Viser overskriften for regn de siste 24 timene:
            ///
            HStack {
                Image(systemName: "drop.fill")
                    .renderingMode(.original)
                    .font(Font.headline.weight(.regular))
                Text("PRECIPITATION")
                    .font(.system(size: 15, weight: .bold))
            }
            .opacity(0.50)
            .padding(.leading, -76)
            /// Viser regn de neste 24 timene:
            ///
            Text(Precipitation24hBackwards)
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -20)
            Text("Last 24 h")
                .padding(.top, -30)
                .padding(.leading, -75)
            
            /// Viser regn det neste døgn:
            ///
            let a = String(localized: "is expected the next day.")
            Text("\(Precipitation24hForwards) \(a)")
                .lineLimit(4)
                .padding(.top,10)
                .padding(.leading, -21)
                .padding(.bottom, -20)
            Spacer()
        }
        .frame(width: 160, height: 180)
        .padding(15)
        .modifier(DayDetailBackground())
        .task {
            
            /// Bruker location for Varhaug:
            ///
            let location = CLLocation(latitude: latitude!,
                                      longitude: longitude!)
            
            let value: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                     location: location,
                                                                     option: .backward)
            
            Precipitation24hBackwards = value.1
            
            let value1: (Double, String) = await Precipitation24hFind(weather: weather,
                                                                      location: location,
                                                                      option: .forward)
            
            Precipitation24hForwards = value1.1
            
        }
    }
}
