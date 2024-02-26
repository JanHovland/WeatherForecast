//
//  WeatherInfo.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/07/2023.
//

import SwiftUI
import Observation

@Observable final class WeatherInfo {
    var latitude: Double?
    var longitude: Double?
    var placeName: String = ""
    var countryName: String = ""
    var offsetString: String = ""
    var offsetSec: Int = 0
    var dst: Int = 0                    // Day Saving Time = Sommertid
    var zoneName: String = ""           //  "Europe/Oslo"
    var zoneShortName: String = ""      //  "CEST
    ///
    /// Lokale variabler for current Position:
    /// 
    var localLatitude: Double?
    var localLongitude: Double?
    var localPlaceName: String = ""
    var localOffsetString: String = ""
    var localOffsetSec: Int = 0
    var localDate: Date = Date()
    var localCondition: String = ""
    var localTemperature: Double = 0.00
    var localLowTemperature: Double = 0.00
    var localHighTemperature: Double = 0.00 
    var localIsDaylight: Bool = false
    var localFlag: String = ""
    var localCountry: String = ""
    var localDst = 0
    var localZoneName = ""
    var localZoneShortName = ""

    ///
    /// Lokale variabler for valgt sted:
    ///
    var placeLatitude: Double?
    var placeLongitude: Double?
    var placeOffsetString: String = ""
    var placeOffsetSec: Int = 0
    
}
