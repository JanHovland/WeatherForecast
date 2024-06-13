//
//  MapOpen.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/12/2023.
//

import SwiftUI
import MapKit

func MapOpen(address: String?) {
    UIApplication.shared.open(URL(string: "http://maps.apple.com/?address=\(address ?? "")")!)
}
