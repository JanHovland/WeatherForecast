// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let averageData = try? JSONDecoder().decode(AverageData.self, from: jsonData)

import Foundation

// MARK: - AverageData
struct AverageDailyData: Codable {
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
    let precipitationSum: [Double]
    let apparentTemperatureMin, apparentTemperatureMax: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
        case apparentTemperatureMin = "apparent_temperature_min"
        case apparentTemperatureMax = "apparent_temperature_max"
    }
}

// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, precipitationSum, apparentTemperatureMin, apparentTemperatureMax: String

    enum CodingKeys: String, CodingKey {
        case time
        case precipitationSum = "precipitation_sum"
        case apparentTemperatureMin = "apparent_temperature_min"
        case apparentTemperatureMax = "apparent_temperature_max"
    }
}
