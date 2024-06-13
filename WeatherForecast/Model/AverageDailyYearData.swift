//
//  AverageDailyYearData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 25/04/2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageDailyYearData = try? JSONDecoder().decode(AverageDailyYearData.self, from: jsonData)

import Foundation

// MARK: - AverageDailyYearData
struct AverageDailyYearData: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits2
    let daily: Daily2

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
struct Daily2: Codable {
    let time: [String]
    let precipitationSum: [Double]?

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
    }
}

// MARK: - DailyUnits
struct DailyUnits2: Codable {
    let time, precipitationSum: String

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
    }
}
