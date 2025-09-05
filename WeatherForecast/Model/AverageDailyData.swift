// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageDailyData = try? JSONDecoder().decode(AverageDailyData.self, from: jsonData)

import Foundation

// MARK: - AverageDailyData
struct AverageDailyData: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let dailyUnits: DailyUnits1
    let daily: Daily1

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
struct Daily1: Codable {
    let time: [String]
    let precipitationSum: [Double?]
    let temperature2MMin, temperature2MMax: [Double?]

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
        case temperature2MMin = "temperature_2m_min"
        case temperature2MMax = "temperature_2m_max"
    }
}

// MARK: - DailyUnits
struct DailyUnits1: Codable {
    let time, precipitationSum, temperature2MMin, temperature2MMax: String

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
        case temperature2MMin = "temperature_2m_min"
        case temperature2MMax = "temperature_2m_max"
    }
}
