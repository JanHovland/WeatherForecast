//
//  Rain24hFindPrecipitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 26/10/2022.
//

import WeatherKit
import MapKit

func Precipitation24hFind(weather: Weather,
                          location: CLLocation,
                          option: EnumType,
                          offsetSec: Int) async -> (Double, String) {

    var startDate : Date = Date()
    var endDate : Date = Date()

    var precipitationAmount : Double = 0.00
    
    ///
    ///     Central European Summer Time (CEST):
    ///         2 hours ahead of Coordinated Universal Time (UTC).
    ///     Central European Time (CET) :
    ///         1 hour ahead of Coordinated Universal Time (UTC).
    ///
    ///     Rain24hFindPrecipitation() bruker alltid UTC.
    ///                     Derfor må datoene korrigeres med antall timer ut fra UTC
    ///
    
    /// https://www.hackingwithswift.com/read/0/14/enumerations
    
    switch option {
    case .forward:
        startDate = DateAddHour(hour: (0 - HoursFromUTC(offsetSec: offsetSec)))
        endDate = DateAddHour(hour: (23 - HoursFromUTC(offsetSec: offsetSec)))
    case .backward:
        startDate = DateAddHour(hour: (-24 - HoursFromUTC(offsetSec: offsetSec)))
        endDate = DateAddHour(hour: (-1 - HoursFromUTC(offsetSec: offsetSec)))
    default:
        _ = Date()
        _ = Date()
    }
    
    precipitationAmount = 0.00
        
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
    
    return (precipitationAmount ,String("\(Int(precipitationAmount.rounded())) mm"))
}
