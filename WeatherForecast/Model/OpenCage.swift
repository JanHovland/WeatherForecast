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
    var type : String?
    var country: String?
    var county: String?
    var postalCity: String?
    var village: String?
    var hamlet: String?
    var neighbourhood: String?
    var city: String?
    var town: String?
    var state: String?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case country
        case county
        case postalCity = "postal_city"
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
}

struct Geometry: Decodable {
    var lat: Double?                // latitude  = breddegrad = 0 meredian går gjennom greenwich
    var lng: Double?                // longitude = lengdegrad
}



