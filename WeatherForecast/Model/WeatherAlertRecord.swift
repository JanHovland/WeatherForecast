//
//  WeatherAlertRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2022.
//

import Foundation
import MapKit

struct WeatherAlertRecord : Identifiable {
    var id = UUID()
    /// The site for more details about the weather alert.
    ///
    /// This is required for attribution.
    var detailsURL : URL
    /// The name of the source issuing the weather alert.
    ///
    /// This is required for attribution.
    var source = String()
    /// The summary of the event type.
    ///
    /// The summary may or may not contain localized descriptions, depending on what is available from the source.
    var summary = String()
    /// The name of the affected area.
    var region: String?
    /// The severity of the weather alert.
    var severity = String()
    /// The current weather metadata.
    /// The time of the weather data request.
    /// struct WeatherMetadata
    var date : Date
    /// The time the weather data expires.
    var expirationDate: Date
    /// The location of the request.
    var location: CLLocation
}
