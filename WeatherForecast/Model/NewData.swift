//
//  NewData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 18/10/2023.
//

import Foundation

struct AverageHourMinTemperature: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct AverageHourMaxTemperature: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct AverageTemperature: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewData: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewTemperature: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewFeelsLike: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewWind: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewFeel: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewUvIndex: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewVisibility: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewAirPressure: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewHumidity: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewPrecipitation: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

struct NewProbability: Identifiable {
    var id = UUID()
    var type: String
    var hour: Int
    var value: Double
}

