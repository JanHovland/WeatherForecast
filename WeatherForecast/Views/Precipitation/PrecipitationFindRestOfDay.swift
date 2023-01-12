//
//  PrecipitationFindRestOfDay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 11/01/2023.
//

import WeatherKit
import MapKit

func PrecipitationFindRestOfDay(weather: Weather,
                                location: CLLocation) async -> Double {

    let startDate : Date = GetLocalDate(date: Date())
    let endDate : Date = MidNight(date: Date())

    var precipitationAmount : Double = 0.00
    
    do {
        let forecast = try await WeatherService.shared.weather(for: location,
                                                               including: .hourly(startDate: startDate,
                                                                                  endDate: endDate))
        forecast.forEach { item in
            precipitationAmount = precipitationAmount + item.precipitationAmount.value
        }
    } catch {
        debugPrint(error)
    }
    
    return precipitationAmount
}

