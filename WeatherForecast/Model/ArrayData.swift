//
//  ArrayData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/03/2024.
//

import Foundation


// MARK: - ArrayData
struct ArrayData: Codable {
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
    let temperature2MMean: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMean = "temperature_2m_mean"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, temperature2MMean: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2MMean = "temperature_2m_mean"
    }
}
