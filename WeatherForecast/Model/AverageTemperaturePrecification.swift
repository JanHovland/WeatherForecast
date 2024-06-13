//
//  AverageTemperaturePrecification.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/02/2024.
//

import Foundation

/*
// MARK: - AverageTemperaturePrecification
struct AverageTemperaturePrecification: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case dailyUnits = "daily_units"
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let time: [String]
    let temperature2MMean, precipitationSum: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMean = "temperature_2m_mean"
        case precipitationSum = "precipitation_sum"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, temperature2MMean, precipitationSum: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMean = "temperature_2m_mean"
        case precipitationSum = "precipitation_sum"
    }
}

/*
 
 /// https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&start_date=2023-12-01&end_date=2023-12-31&daily=temperature_2m_mean,precipitation_sum
 
 {
   "latitude": 52.54833,
   "longitude": 13.407822,
   "generationtime_ms": 0.06401538848876953,
   "utc_offset_seconds": 0,
   "timezone": "GMT",
   "timezone_abbreviation": "GMT",
   "elevation": 38,
   "daily_units": {
     "time": "iso8601",
     "temperature_2m_mean": "°C",
     "precipitation_sum": "mm"
   },
   "daily": {
     "time": [
       "2023-12-01",
       "2023-12-02",
       "2023-12-03",
       "2023-12-04",
       "2023-12-05",
       "2023-12-06",
       "2023-12-07",
       "2023-12-08",
       "2023-12-09",
       "2023-12-10",
       "2023-12-11",
       "2023-12-12",
       "2023-12-13",
       "2023-12-14",
       "2023-12-15",
       "2023-12-16",
       "2023-12-17",
       "2023-12-18",
       "2023-12-19",
       "2023-12-20",
       "2023-12-21",
       "2023-12-22",
       "2023-12-23",
       "2023-12-24",
       "2023-12-25",
       "2023-12-26",
       "2023-12-27",
       "2023-12-28",
       "2023-12-29",
       "2023-12-30",
       "2023-12-31"
     ],
     "temperature_2m_mean": [
       -5.4,
       -3.3,
       -2.9,
       -2.9,
       -1.4,
       0.1,
       0.2,
       0.4,
       2.3,
       4.9,
       7,
       5.2,
       4.2,
       2.6,
       3.1,
       6.8,
       7.9,
       6.2,
       6.9,
       5.3,
       6.7,
       2.9,
       2,
       7.3,
       9.2,
       8,
       3.8,
       8.1,
       8.9,
       6,
       5.5
     ],
     "precipitation_sum": [
       0,
       0,
       0,
       0,
       0.8,
       2,
       0,
       1.7,
       1.2,
       8.2,
       17,
       1.6,
       9.9,
       0.9,
       0.5,
       0.1,
       0,
       0,
       7.9,
       5.9,
       17.1,
       2.5,
       3.3,
       12.2,
       6.1,
       16.1,
       0,
       0,
       7,
       2.5,
       1.6
     ]
   }
 }
 */

*/
