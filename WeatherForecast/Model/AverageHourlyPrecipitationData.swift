// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageHourlyYearData = try? JSONDecoder().decode(AverageHourlyYearData.self, from: jsonData)

import Foundation

// MARK: - AverageHourlyPrecipitationData
struct AverageHourlyPrecipitationData: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let hourlyUnits: HourlyUnits1
    let hourly: Hourly1

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - Hourly
struct Hourly1: Codable {
    let time: [String]
    let precipitation: [Double]
}

// MARK: - HourlyUnits1
struct HourlyUnits1: Codable {
    let time, precipitation: String
}
