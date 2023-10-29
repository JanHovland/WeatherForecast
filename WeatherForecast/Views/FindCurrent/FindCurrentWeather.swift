//
//  FindCurrentLocation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 26/01/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

///
/// Finner altuelt vær og setter currentWeather:
///
func FindCurrentWeather(_ latitude: Double, _ longitude: Double, offsetSec: Int) async -> (Weather) {
    
    var weather : Weather?
    
    let currentWeather = CurrentWeather()
    
    let location = CLLocation(latitude: latitude , longitude: longitude )
    
    do {
        weather = try await WeatherService.shared.weather(for: location)
        if weather != nil  {
            ///
            /// Oppdaterer currentWeather:
            ///
            currentWeather.date = weather!.currentWeather.date
            currentWeather.hour = Int(FormatDateToString(date: currentWeather.date, format: ("HH"), offsetSec: offsetSec))!
            currentWeather.cloudCover = weather!.currentWeather.cloudCover
            currentWeather.condition = weather!.currentWeather.condition.description
            currentWeather.symbolName = weather!.currentWeather.symbolName
            currentWeather.dewPoint = weather!.currentWeather.dewPoint.value
            currentWeather.humidity = weather!.currentWeather.humidity
            currentWeather.pressure = weather!.currentWeather.pressure.value
            currentWeather.isDaylight = weather!.currentWeather.isDaylight
            currentWeather.temperature = weather!.currentWeather.temperature.value
            currentWeather.apparentTemperature = weather!.currentWeather.apparentTemperature.value
            currentWeather.uvIndex = weather!.currentWeather.uvIndex.value
            currentWeather.visibility = weather!.currentWeather.visibility.value
            currentWeather.windSpeed = weather!.currentWeather.wind.speed.value
            currentWeather.windGust = weather!.currentWeather.wind.gust?.value ?? 0.00
            currentWeather.windDirection = weather!.currentWeather.wind.direction.value
        }
    } catch {
        debugPrint(error)
    }
   
    return (weather!)
    
}
