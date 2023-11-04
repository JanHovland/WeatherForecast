//
//  FindMoonUpDown.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import Foundation


func FindMoonUpDown(url: String,
                   offset: String,
                   latitude : Double?,
                   longitude: Double?,
                   offsetSec: Int) async -> (String) {
    
    var errors : String = ""
    var lat: String = ""
    var lon: String = ""
    
    if latitude != nil {
        lat = "\(latitude!)"
    } else {
        lat = "\(58.618050)" /// Varhaug
    }
    if longitude != nil {
        lon = "\(longitude!)"
    } else {
        lon = "\(5.655520)"  /// Varhaug
    }
               
    ///
    /// Blindern, Oslo
    /// https://api.met.no/weatherapi/sunrise/3.0/moon?lat=59.933333&lon=10.716667&date=2023-11-01&offset=+01:00
    ///

    let date = Date().setTime(hour: 0, min: 0, sec: 0) ?? Date()
    let calculatedDate = FormatDateToString(date: date, format: "yyyy-MM-dd", offsetSec: offsetSec)
    let urlString = url + "lat=" + lat + "&lon=" + lon + "&date=" + calculatedDate + "&offset=" + offset
    let url = URL(string: urlString)
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, _) = try await urlSession.data(from: url)
            let metApiMoon = try? JSONDecoder().decode(MetApiMoon.self, from: jsonData)
        } catch {
            errors = "\(error)"
        }
    }
    return (errors
    
    )
}

/*
 {
   "copyright": "MET Norway",
   "licenseURL": "https://api.met.no/license_data.html",
   "type": "Feature",
   "geometry": {
     "type": "Point",
     "coordinates": [
       5.3,
       60.3
     ]
   },
   "when": {
     "interval": [
       "2023-11-03T23:38:00Z",
       "2023-11-04T23:38:00Z"
     ]
   },
   "properties": {
     "body": "Moon",
     "moonrise": {
       "time": "2023-11-04T21:04+01:00",
       "azimuth": 36.13
     },
     "moonset": {
       "time": "2023-11-04T15:43+01:00",
       "azimuth": 326.17
     },
     "high_moon": {
       "time": "2023-11-04T05:54+01:00",
       "disc_centre_elevation": 54.72,
       "visible": true
     },
     "low_moon": {
       "time": "2023-11-04T18:18+01:00",
       "disc_centre_elevation": -6.57,
       "visible": false
     },
     "moonphase": 254.81
   }
 }
 */
