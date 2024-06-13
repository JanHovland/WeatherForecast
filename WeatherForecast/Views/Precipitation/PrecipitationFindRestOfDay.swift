//
//  PrecipitationFindRestOfDay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 11/01/2023.
//

import WeatherKit
import MapKit

func PrecipitationFindRestOfDay(weather: Weather,
                                location: CLLocation,
                                date: Date) async -> Double {

    let startDate = date
    let endDate : Date = MidNight(date: date)
    var precipitationAmount : Double = 0.00
    
    do {
        ///
        /// ved å inkludere including: finnes historiske data:
        ///
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

