//
//  FindCurrentLocation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 26/01/2023.
//

import SwiftUI
import CoreLocation
import WeatherKit

///
/// Finner nåværende posisjon:
///
func FindCurrentLocation() async -> (latitude: Double,
                                     longitude: Double,
                                     place: String,
                                     offsetString: String,
                                     offsetSec: Int,
                                     date: Date,
                                     condition: String,
                                     temperature: Double,
                                     lowTemperature: Double,
                                     highTemperature: Double,
                                     isDaylight: Bool,
                                     flag: String,
                                     country: String,
                                     dst: Int,
                                     zoneName: String,
                                     zoneShortName: String)  {
    var geoRecord: GeoRecord
    var weather: Weather?
    let weatherService = WeatherService.shared
    var latitude: Double = 0.00
    var longitude: Double = 0.00
    var offsetString: String = ""
    var offsetSec: Int = 0
    var condition: String = ""
    var date: Date = Date()
    var temperature: Double = 0.00
    var lowTemperature: Double = 0.00
    var highTemperature: Double = 0.00
    var isDaylight: Bool = false
    var flag: String = ""
    var country: String = ""
    var dst: Int = 0                        /// Sommertid DailySaving Time
    var zoneShortName: String = ""
    var zoneName: String = ""
    
    let value : (Double, Double)
    value = await GetCurrentLocation()
    latitude = value.0
    longitude = value.1
    
    let key = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
    let urlOpenCage = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
    ///
    /// Finner stedet til currentLocation:
    ///
    geoRecord = await GetReverseGeoCode(latitude: latitude,
                                        longitude: longitude,
                                        key: key,
                                        urlOpenCage: urlOpenCage)
    ///
    /// Tilpasser offset : "+0100" -> "+01:00"
    ///
    offsetString = AdjustOffset(geoRecord.offsetString)
    offsetSec = geoRecord.offsetSec
    ///
    /// Finner dst og zone names
    ///
    dst = geoRecord.dst
    zoneName = geoRecord.zoneName
    zoneShortName = geoRecord.zoneShortName
    ///
    ///
    /// Finner flagg og land:
    ///
    flag = geoRecord.flag
    country = geoRecord.country
    ///
    /// Tilpasser datoen til UTC:
    ///
    date = Date()
    ///
    /// Finn local: Temperature, lowTemperature og highTemperature:
    /// Finn local: Condition og isDaylight:
    ///
    weather = nil
    let location = CLLocation(latitude: latitude , longitude: longitude)
    do {
        weather = try await weatherService.weather(for: location)
        if let weather {
            condition = weather.currentWeather.condition.description
            temperature = weather.currentWeather.temperature.value
            if weather.dailyForecast.forecast.count > 0 {
                lowTemperature = weather.dailyForecast.forecast[0].lowTemperature.value
                highTemperature =  weather.dailyForecast.forecast[0].highTemperature.value
            }
            isDaylight = weather.currentWeather.isDaylight
        }
    } catch {
        debugPrint(error)
    }
    return (latitude,
            longitude,
            geoRecord.place,
            offsetString,
            offsetSec,
            date,
            condition,
            temperature,
            lowTemperature,
            highTemperature,
            isDaylight,
            flag,
            country,
            dst,
            zoneName,
            zoneShortName)
}
