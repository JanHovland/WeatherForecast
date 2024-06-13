//
//  AirQuality.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/10/2023.
//

import Foundation

/*
 {
   "coord": {
     "lon": 5.3259,
     "lat": 60.3943
   },
   "list": [
     {
       "main": {
         "aqi": 1
       },
       "components": {
         "co": 273.71,
         "no": 0.12,
         "no2": 6.86,
         "o3": 25.03,
         "so2": 1.49,
         "pm2_5": 1.5,
         "pm10": 2.29,
         "nh3": 0.37
       },
       "dt": 1698569290
     }
   ]
 }
*/

// MARK: - Air
struct AirQuality: Codable {
    let coord: Coord
    let list: [Liste]
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Liste
struct Liste: Codable {
    let main: Main
    let components: Component
    let dt: Int
}

// MARK: - Main
struct Main: Codable {
    let aqi: Int
}

// MARK: - Component
struct Component: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}
