//
//  MetApiMoon.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2023.
//

import Foundation

//// MARK: - MetApiMoon
struct MetApiMoon: Codable {
    let copyright: String
    let licenseURL: String
    let type: String
    let geometry: GeometryMoon
    let when: When
    let properties: PropertiesMoon
}

// MARK: - Geometry
struct GeometryMoon: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct PropertiesMoon: Codable {
    let body: String
    let moonrise, moonset: MoonriseClass
    let highMoon, lowMoon: Moon
    let moonphase: Double

    enum CodingKeys: String, CodingKey {
        case body, moonrise, moonset
        case highMoon = "high_moon"
        case lowMoon = "low_moon"
        case moonphase
    }
}

// MARK: - Moon
struct Moon: Codable {
    let time: String
    let discCentreElevation: Double
    let visible: Bool

    enum CodingKeys: String, CodingKey {
        case time
        case discCentreElevation = "disc_centre_elevation"
        case visible
    }
}

// MARK: - MoonriseClass
struct MoonriseClass: Codable {
    let time: String
    let azimuth: Double
}

// MARK: - When
struct When: Codable {
    let interval: [Date]
}
