//
//  OpenCage.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import Foundation

struct OpenCage: Decodable {
    var results = [Result()]
}
    
struct Result: Decodable {
    var annotations = Annotations()
    var components = Components()
    var formatted : String?
    var geometry = Geometry()
}

struct Components: Decodable {
    var category: String?
    var type : String?
    var continent: String?
    var country: String?
    var countryCode: String?
    var county: String?
    var municipality: String?
    var postalCity: String?
    var postcode: String?
    var village: String?
    var hamlet: String?
    var neighbourhood: String?
    var city: String?
    var town: String?
    var state: String?

    enum CodingKeys: String, CodingKey {
        case category = "_category"
        case type = "_type"
        case continent
        case country
        case countryCode = "country_code"
        case county
        case municipality
        case postalCity = "postal_city"
        case postcode
        case village
        case hamlet
        case neighbourhood
        case city
        case town
        case state
    }
}

struct Annotations: Decodable {
    var flag : String?
    var timezone = Timezone()
}

struct Geometry: Decodable {
    var lat: Double?                // latitude  = breddegrad = 0 meredianen ved Greenwich
    var lng: Double?                // longitude = lengdegrad
}

struct Timezone: Decodable {
    var name: String?
    var nowInDST: Int?
    var offsetSec: Int?
    var offsetString: String?
    var shortName: String?
    
    enum CodingKeys: String, CodingKey {
        case name                                 //  "Europe/Oslo"
        case nowInDST = "now_in_dst"              //   0 = ikke sommertid 1 = sommertid
        case offsetSec = "offset_sec"             //   3600 som er +1 time(r) i forhold til UTC
        case offsetString = "offset_string"       //  "+0100" som er +1 time(r) i forhold til UTC
        case shortName = "short_name"             //  "CET"  CET  = Central European Time
                                                  //  "CEST" CEST = Central European Summer Time
    }
        
}

