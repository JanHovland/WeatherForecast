    // This file was generated from JSON Schema using quicktype, do not modify it directly.
    // To parse the JSON, add this file to your project and do:
    //
    //   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//    import Foundation
//
//    // MARK: - Welcome
//    struct Welcome: Codable {
//        let sun: Sun
//        let timestamp: Int
//        let datestamp: String
//        let moon: Moon
//        let plan: String
//    }
//
//    // MARK: - Moon
//    struct Moon: Codable {
//        let moonriseTimestamp: Int
//        let moonsetTimestamp: JSONNull?
//        let detailed: Detailed
//        let illumination: String
//        let nextLunarEclipse: NextArEclipse
//        let phaseName: String
//        let phase: Double
//        let majorPhase, stage, lunarCycle: String
//        let moonset: JSONNull?
//        let emoji: String
//        let zodiac: Zodiac
//        let moonrise: String
//        let ageDays: Int
//        let events: Events
//
//        enum CodingKeys: String, CodingKey {
//            case moonriseTimestamp = "moonrise_timestamp"
//            case moonsetTimestamp = "moonset_timestamp"
//            case detailed, illumination
//            case nextLunarEclipse = "next_lunar_eclipse"
//            case phaseName = "phase_name"
//            case phase
//            case majorPhase = "major_phase"
//            case stage
//            case lunarCycle = "lunar_cycle"
//            case moonset, emoji, zodiac, moonrise
//            case ageDays = "age_days"
//            case events
//        }
//    }
//
//    // MARK: - Detailed
//    struct Detailed: Codable {
//        let visibility: Visibility
//        let illuminationDetails: IlluminationDetails
//        let upcomingPhases: UpcomingPhases
//        let position: DetailedPosition
//
//        enum CodingKeys: String, CodingKey {
//            case visibility
//            case illuminationDetails = "illumination_details"
//            case upcomingPhases = "upcoming_phases"
//            case position
//        }
//    }
//
//    // MARK: - IlluminationDetails
//    struct IlluminationDetails: Codable {
//        let phaseAngle, percentage, visibleFraction: Double
//
//        enum CodingKeys: String, CodingKey {
//            case phaseAngle = "phase_angle"
//            case percentage
//            case visibleFraction = "visible_fraction"
//        }
//    }
//
//    // MARK: - DetailedPosition
//    struct DetailedPosition: Codable {
//        let parallacticAngle, phaseAngle, azimuth, distance: Double
//        let altitude: Double
//
//        enum CodingKeys: String, CodingKey {
//            case parallacticAngle = "parallactic_angle"
//            case phaseAngle = "phase_angle"
//            case azimuth, distance, altitude
//        }
//    }
//
//    // MARK: - UpcomingPhases
//    struct UpcomingPhases: Codable {
//        let fullMoon: FullMoon
//        let firstQuarter, lastQuarter, newMoon: FirstQuarter
//
//        enum CodingKeys: String, CodingKey {
//            case fullMoon = "full_moon"
//            case firstQuarter = "first_quarter"
//            case lastQuarter = "last_quarter"
//            case newMoon = "new_moon"
//        }
//    }
//
//    // MARK: - FirstQuarter
//    struct FirstQuarter: Codable {
//        let last: FirstQuarterLast
//        let next: Next
//    }
//
//    // MARK: - FirstQuarterLast
//    struct FirstQuarterLast: Codable {
//        let daysAgo: Int
//        let datestamp: String
//        let timestamp: Int
//
//        enum CodingKeys: String, CodingKey {
//            case daysAgo = "days_ago"
//            case datestamp, timestamp
//        }
//    }
//
//    // MARK: - Next
//    struct Next: Codable {
//        let daysAhead: Int
//        let datestamp: String
//        let timestamp: Int
//
//        enum CodingKeys: String, CodingKey {
//            case daysAhead = "days_ahead"
//            case datestamp, timestamp
//        }
//    }
//
//    // MARK: - FullMoon
//    struct FullMoon: Codable {
//        let last, next: NextClass
//    }
//
//    // MARK: - NextClass
//    struct NextClass: Codable {
//        let timestamp: Int
//        let datestamp, name: String
//        let daysAgo: Int?
//        let description: String
//        let daysAhead: Int?
//
//        enum CodingKeys: String, CodingKey {
//            case timestamp, datestamp, name
//            case daysAgo = "days_ago"
//            case description
//            case daysAhead = "days_ahead"
//        }
//    }
//
//    // MARK: - Visibility
//    struct Visibility: Codable {
//        let bestViewingTime, visibilityRating, illumination: String
//        let visibleHours: Int
//        let viewingConditions: ViewingConditions
//
//        enum CodingKeys: String, CodingKey {
//            case bestViewingTime = "best_viewing_time"
//            case visibilityRating = "visibility_rating"
//            case illumination
//            case visibleHours = "visible_hours"
//            case viewingConditions = "viewing_conditions"
//        }
//    }
//
//    // MARK: - ViewingConditions
//    struct ViewingConditions: Codable {
//        let recommendedEquipment: RecommendedEquipment
//        let phaseQuality: String
//
//        enum CodingKeys: String, CodingKey {
//            case recommendedEquipment = "recommended_equipment"
//            case phaseQuality = "phase_quality"
//        }
//    }
//
//    // MARK: - RecommendedEquipment
//    struct RecommendedEquipment: Codable {
//        let filters, bestMagnification, telescope: String
//
//        enum CodingKeys: String, CodingKey {
//            case filters
//            case bestMagnification = "best_magnification"
//            case telescope
//        }
//    }
//
//    // MARK: - Events
//    struct Events: Codable {
//        let optimalViewingPeriod: OptimalViewingPeriod
//        let moonsetVisible: JSONNull?
//        let moonriseVisible: Bool
//
//        enum CodingKeys: String, CodingKey {
//            case optimalViewingPeriod = "optimal_viewing_period"
//            case moonsetVisible = "moonset_visible"
//            case moonriseVisible = "moonrise_visible"
//        }
//    }
//
//    // MARK: - OptimalViewingPeriod
//    struct OptimalViewingPeriod: Codable {
//        let recommendations: [String]
//        let durationHours: Int
//        let viewingQuality, startTime, endTime: String
//
//        enum CodingKeys: String, CodingKey {
//            case recommendations
//            case durationHours = "duration_hours"
//            case viewingQuality = "viewing_quality"
//            case startTime = "start_time"
//            case endTime = "end_time"
//        }
//    }
//
//    // MARK: - NextArEclipse
//    struct NextArEclipse: Codable {
//        let timestamp: Int
//        let datestamp, type, visibilityRegions: String
//
//        enum CodingKeys: String, CodingKey {
//            case timestamp, datestamp, type
//            case visibilityRegions = "visibility_regions"
//        }
//    }
//
//    // MARK: - Zodiac
//    struct Zodiac: Codable {
//        let sunSign, moonSign: String
//
//        enum CodingKeys: String, CodingKey {
//            case sunSign = "sun_sign"
//            case moonSign = "moon_sign"
//        }
//    }
//
//    // MARK: - Sun
//    struct Sun: Codable {
//        let sunset: Int
//        let position: SunPosition
//        let sunrise: Int
//        let solarNoon, sunriseTimestamp, dayLength, sunsetTimestamp: String
//        let nextSolarEclipse: NextArEclipse
//
//        enum CodingKeys: String, CodingKey {
//            case sunset, position, sunrise
//            case solarNoon = "solar_noon"
//            case sunriseTimestamp = "sunrise_timestamp"
//            case dayLength = "day_length"
//            case sunsetTimestamp = "sunset_timestamp"
//            case nextSolarEclipse = "next_solar_eclipse"
//        }
//    }
//
//    // MARK: - SunPosition
//    struct SunPosition: Codable {
//        let azimuth, distance, altitude: Double
//    }
//
//    // MARK: - Encode/decode helpers
//
//    class JSONNull: Codable, Hashable {
//
//        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//                return true
//        }
//
//        public var hashValue: Int {
//                return 0
//        }
//
//        public init() {}
//
//        public required init(from decoder: Decoder) throws {
//                let container = try decoder.singleValueContainer()
//                if !container.decodeNil() {
//                        throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//                }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//                var container = encoder.singleValueContainer()
//                try container.encodeNil()
//        }
//    }
