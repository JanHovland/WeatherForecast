//
//  Place.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/01/2023.
//

import SwiftUI
import CloudKit

struct Place: Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var place: String = ""
    var flag: String = ""
    var country: String = ""
    var lon: Double?
    var lat: Double?
    var offsetSec: Int = 0
    var offsetString: String = ""
    var dst: Int = 0
    var zoneName: String = ""
    var zoneShortName: String = ""
    var temperature: Double = 0.00
    var lowTemperature: Double = 0.00
    var highTemperature: Double = 0.00
    var condition: String = ""
    var isDaylight: Bool = false         /// fra Weather
}
