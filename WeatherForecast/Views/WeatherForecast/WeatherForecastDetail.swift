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
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var option1: EnumType = .number12
    @State private var precification: Double = 0.00
    @State private var date: Date = Date()
    @State private var tempArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    
    var body: some View {
        VStack {
            VStack {
                ///
                /// Viser temperaturen akkurat nå:
                ///
                Text("\(Int(currentWeather.temperature.rounded()))º")
                   .font(.system(size: 70, weight: .ultraLight))
                ///
                /// Beskrivelse av været:
                ///
                Text(weather.currentWeather.condition.description)
                VStack (spacing: 10) {
                    Text(String("H: \(Int(round(tempArray.max()!))) º L: \(Int(round(tempArray.min()!))) º"))
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
            ///
            /// Setter location:
            ///

            let location = CLLocation(latitude: weatherInfo.latitude!,
                                      longitude: weatherInfo.longitude!)
            ///
            /// Finner høyeste og laveste temperatur i løpet av dagen_
            ///
            let fromDate = Date().setTime(hour: 0, min: 0, sec: 0)

            let value: ([Double],
                        [String],
                        [String],
                        [WindInfo],
                        [Temperature],
                        [Double],
                        [WeatherIcon],
                        [Double],
                        [FeltTemp],
                        [Double],
                        [NewPrecipitation]) = FindDataFromMenu(info: "WeatherForecastDetail: dagens høy/lav temp + nedbør",
                                                               weather: weather,
                                                               date: fromDate!,
                                                               option: .temperature,
                                                               option1: option1)
            tempArray = value.0
            
            ///
            /// Finner nedbør for resten av dagen:
            ///
            let date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
            precification = await PrecipitationFindRestOfDay(weather: weather,
                                                             location: location,
                                                             date: date)
        }
    }
}


