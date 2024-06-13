//
//  FindLocalPosition.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/06/2023.
//

import CoreLocation
import SwiftUI

@MainActor func FindLocalPosition() async -> (Double, Double) {
    @ObservedObject var locationsHandler = LocationsHandler.shared
    var lat: Double = 0.00
    var lon: Double = 0.00
    do {
        let updates = CLLocationUpdate.liveUpdates()
        for try await update in updates {
            if let loc = update.location {
                let lastLocation = loc
                if lastLocation.coordinate.latitude != 0.00 {
                    lat = lastLocation.coordinate.latitude
                    lon = lastLocation.coordinate.longitude
                    break
                }
            }
        }
    } catch {
        debugPrint(error)
    }
    return (lat, lon)
}

