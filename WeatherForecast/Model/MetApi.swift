//
//  MetApi.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2022.
//

import Foundation

/// This file was generated from JSON Schema using quicktype, do not modify it directly.
/// To parse the JSON, add this file to your project and do:
///
///   let metAPI = try JSONDecoder().decode(MetAPI.self, from: jsonData)

// MARK: - MetAPI
struct MetApi: Codable {
    var location: Location
    var meta: Meta
}

// MARK: - Location
struct Location: Codable {
    let height, latitude, longitude: String
    let time: [Time]
}

// MARK: - Time
struct Time: Codable {
    let date: String
    let highMoon, lowMoon: HighMoon?
    let moonphase: Moonphase?
    let moonposition: Moonposition
    let moonrise, moonset: Moonrise?
    let moonshadow, solarmidnight, solarnoon: HighMoon?
    let sunrise, sunset: Moonrise?

    enum CodingKeys: String, CodingKey {
        case date
        case highMoon = "high_moon"
        case lowMoon = "low_moon"
        case moonphase, moonposition, moonrise, moonset, moonshadow, solarmidnight, solarnoon, sunrise, sunset
    }
}

// MARK: - HighMoon
struct HighMoon: Codable {
    let desc, elevation: String
    let time: String
    let azimuth: String?
}

// MARK: - Moonphase
struct Moonphase: Codable {
    let desc: String
    let time: String
    let value: String
}

// MARK: - Moonposition
struct Moonposition: Codable {
    let azimuth, desc, elevation, phase: String
    let range: String
    let time: String
}

// MARK: - Moonrise
struct Moonrise: Codable {
    let desc: String
    let time: String
}

// MARK: - Meta
struct Meta: Codable {
    let licenseurl: String
}
