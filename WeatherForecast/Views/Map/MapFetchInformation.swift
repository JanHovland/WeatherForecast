//
//  MapFetchInformation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2023.
//

import SwiftUI
import MapKit

func MapFetchInformation(latitude: Double,
                         longitude: Double) {

    var address: String = ""
    let location = CLLocation(latitude: latitude, longitude: longitude)
    ///
    /// Finner map informasjon ut fra koordinatene
    ///
    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
        guard let placemark = placemarks?.first, error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        // Construct a string with information about the location
        address = "\(placemark.name ?? "")" +
        " \(placemark.thoroughfare ?? "")" +
        " \(placemark.locality ?? "")" +
        " \(placemark.postalCode ?? "")" +
        " \(placemark.country ?? "")"
        ///
        /// Finner informasjon om vlgt sted
        ///
        MapOpen(address: (address.replacingOccurrences(of: " ", with: ",")))
    }
}

