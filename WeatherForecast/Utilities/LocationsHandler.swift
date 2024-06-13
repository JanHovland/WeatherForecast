//
//  LocationsHandler.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/06/2023.
//

import CoreLocation

@MainActor class LocationsHandler: ObservableObject {
    
    static let shared = LocationsHandler()
    private let manager: CLLocationManager
    @Published
    var lastLocation = CLLocation()
    @Published
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet { UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted") }
    }
    
    private init() {
        self.manager = CLLocationManager()
    }
    
    func startLocationUpdates() {
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
        Task() {
            do {
                self.updatesStarted = true
                let updates = CLLocationUpdate.liveUpdates()
                for try await update in updates {
                    if !self.updatesStarted { break }
                    if let loc = update.location {
                        self.lastLocation = loc
                        if self.lastLocation.coordinate.latitude != 0.00 {
                            self.updatesStarted = false
                        }
                    }
                }
            } catch {
                debugPrint(error)
            }
            return
        }
    }
}

