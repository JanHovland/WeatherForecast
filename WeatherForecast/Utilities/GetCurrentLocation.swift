//
//  LocationViewModel.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/01/2023.
//

import SwiftUI
import CoreLocation

///
/// GetCurrentLocation returnerer latitude og longitude:
///
func GetCurrentLocation() async -> (latitude: Double, longitude: Double) {
    
    var latitude: Double = 0.00
    var longitude: Double = 0.00

    var value: (Double, Double)
    value = await FindLocalPosition()
    latitude = value.0
    longitude = value.1
    
    return (latitude, longitude)
}
