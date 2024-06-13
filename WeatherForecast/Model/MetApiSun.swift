//
//  MetApi.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2022.
//

import Foundation

/*

/// This file was generated from JSON Schema using quicktype, do not modify it directly.
/// To parse the JSON, add this file to your project and do:
///
///   let metAPI = try? JSONDecoder().decode(MetAPI.self, from: jsonData)

// MARK: - MetAPI
struct MetApi: Codable {
    let location: Location?
    let meta: Meta?
}

// MARK: - Location
struct Location: Codable {
    let height, latitude, longitude: String?
    let time: [Time]?
}

// MARK: - Time
struct Time: Codable {
    let date: String?
    let highMoon, lowMoon: HighMoon?
    let moonphase: Moonphase?
    let moonposition: Moonposition?
    let moonrise: Moonrise?
    let moonset: Moonrise?
    let moonshadow: HighMoon?
    let solarmidnight: Solarmidnight?
    let solarnoon, sunrise, sunset: HighMoon?

    enum CodingKeys: String, CodingKey {
        case date
        case highMoon = "high_moon"
        case lowMoon = "low_moon"
        case moonphase, moonposition, moonrise, moonset, moonshadow, solarmidnight, solarnoon
        case sunrise, sunset
    }
}

// MARK: - HighMoon
struct HighMoon: Codable {
    let desc, elevation: String?
    let time: String?
    let azimuth: String?
}

// MARK: - Moonphase
struct Moonphase: Codable {
    let desc: String?
    let time: String?
    let value: String?
}

// MARK: - Moonposition
struct Moonposition: Codable {
    let azimuth, desc, elevation, phase: String?
    let range: String?
    let time: String?
}

// MARK: - Moonrise
struct Moonrise: Codable {
    let desc: String?
    let time: String?
}

// MARK: - Meta
struct Meta: Codable {
    let licenseurl: String?
}

enum Solarmidnight: Codable {
    case highMoon(HighMoon)
    case highMoonArray([HighMoon])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([HighMoon].self) {
            self = .highMoonArray(x)
            return
        }
        if let x = try? container.decode(HighMoon.self) {
            self = .highMoon(x)
            return
        }
        throw DecodingError.typeMismatch(Solarmidnight.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Solarmidnight"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .highMoon(let x):
            try container.encode(x)
        case .highMoonArray(let x):
            try container.encode(x)
        }
    }
}

*/

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
       "2023-10-28T23:22:00Z",
       "2023-10-29T23:38:00Z"
     ]
   },
   "properties": {
     "body": "Sun",
     "sunrise": {
       "time": "2023-10-29T08:53+02:00",
       "azimuth": 116.23
     },
     "sunset": {
       "time": "2023-10-29T17:50+02:00",
       "azimuth": 243.51
     },
     "solarnoon": {
       "time": "2023-10-29T13:22+02:00",
       "disc_centre_elevation": 16.25,
       "visible": true
     },
     "solarmidnight": {
       "time": "2023-10-29T01:22+02:00",
       "disc_centre_elevation": -42.98,
       "visible": false
     }
   }
 }
 */



// MARK: - MetAPISun
struct MetApiSun: Codable {
//    let copyright: String?
//    let licenseURL: String?
//    let type: String?
//    let geometry: Geometry1?
//    let when: When?
    let properties: Properties?
}

// MARK: - Geometry1
//struct Geometry1: Codable {
//    let type: String
//    let coordinates: [Double]
//}

// MARK: - Properties
struct Properties: Codable {
//    let body: String
    let sunrise, sunset: Sun1
//    let solarnoon, solarmidnight: Solar
}

// MARK: - Solar
//struct Solar: Codable {
//    let time: String
//    let discCentreElevation: Double
//    let visible: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case time
//        case discCentreElevation = "disc_centre_elevation"
//        case visible
//    }
//}

// MARK: - Sun
struct Sun1: Codable {
    let time: String
//    let azimuth: Double
}

// MARK: - When
//struct When: Codable {
//    let interval: [Date] 
//}
