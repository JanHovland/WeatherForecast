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
    
    ///
    /// Økning / minking av lenden på dagslys
    ///
    
    var dayLength: Int = 0
    var dayIncrease: Int = 0

    ///
    /// https://openweathermap.org/api/air-pollution#concept
    /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
    var aqi = Int()
    ///  Сoncentration of CO (Carbon monoxide), μg/m3
    var co = Double()
    /// Сoncentration of NO (Nitrogen monoxide), μg/m3
    var no = Double()
    /// Сoncentration of NO2 (Nitrogen dioxide), μg/m3
    var no2 = Double()
    /// Сoncentration of O3 (Ozone), μg/m
    var o3 = Double()
    /// Сoncentration of SO2 (Sulphur dioxide), μg/m3
    var so2 = Double()
    ///  Сoncentration of PM2.5 (Fine particles matter), μg/m3
    var pm2_5 = Double()
    /// Сoncentration of PM10 (Coarse particulate matter), μg/m3
    var pm10 = Double()
    /// Сoncentration of NH3 (Ammonia), μg/m3
    var nh3 = Double()
    ///  Date and time, Unix, UTC
    var dt = Int()
}
