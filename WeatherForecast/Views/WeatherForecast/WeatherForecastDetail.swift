//
//  WeatherForecastDetail.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI
import WeatherKit
import MapKit

struct WeatherForecastDetail: View {
    var weather : Weather
    var geoRecord: GeoRecord
    
    @EnvironmentObject var currentWeather: CurrentWeather
   
    @State private var option1: EnumType = .number12
    @State private var precification: Double = 0.00
    
    var body: some View {
        VStack {
            VStack {
                /// Viser temperaturen akkurat nå:
                ///
                let temperature = Measurement<UnitTemperature>(value: round(weather.currentWeather.temperature.value),
                    unit: .celsius).formatted()
                Text(temperature)
                   .font(.system(size: 70, weight: .ultraLight))
                
                /// Beskrivelse av været:
                ///
                Text(weather.currentWeather.condition.description)
                
                /// Viser høyeste og laveste temperatur:
                ///
                let value: ([Double],
                            [String],
                            [String],
                            [RainFall],
                            [WindInfo],
                            [Temperature],
                            [Double],
                            [WeatherIcon],
                            [Double],
                            [FeltTemp],
                            [Double]) = FindDataFromMenu(weather: weather,
                                                         date: currentWeather.date,
                                                         option: .temperature,
                                                         option1: option1)
                let array = value.0
                
                VStack (spacing: 10) {
                    Text(String("H: \(Int(round(array.max()!))) º L: \(Int(round(array.min()!))) º"))
                        .padding(.top, 5)
                    if precification > 0.00 {
                        Text(String(localized: "Precification will continue the rest of the day."))
                    } else {
                        Text(String(localized: "No precification for the rest of the day."))
                    }
                }
            }
        }
        .task {
            let location = CLLocation(latitude: latitude!,
                                      longitude: longitude!)
            precification = await PrecipitationFindRestOfDay(weather: weather,
                                                             location: location)
        }
    }
}


