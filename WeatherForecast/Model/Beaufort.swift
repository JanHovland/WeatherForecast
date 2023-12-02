//
//  Beaufort.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 02/12/2023.
//

import SwiftUI

struct Beaufort: Identifiable {
    var id = UUID()
    var image: String = ""
    var value: Int = 0
    var description: String = ""
    var range: String = ""
}
