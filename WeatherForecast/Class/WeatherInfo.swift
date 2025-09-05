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
    var lowTemperature: Double?
    var highTemperature: Double?
    var dailyDeviationTemp: Int = 0
    var normalDailyLowTemp: Double?
    var normalDailyMeanTemp: Double?
    var normalDailyHighTemp: Double?
    var normalMonthlyLowTemp: Double?
    var normalMonthlyHighTemp: Double?
    var precipitationLast30Days: Double?
    var precipitationNormalLast30Days: Double?
    var normalDeviationPrecipitation: Int = 0
    var toDayAverageTemperatureArray: [AverageTemperature] = []
    var toDayAverageTemperatureMaxValue: Double = 0.00
    var toDayAverageTemperatureMaxIndex: Int = 0
    var startYear: String = ""
    var averageDivisor: Int = 0
    var minAverageHourArray: [Double] = []
    var maxAverageHourArray: [Double] = []
    var temperaturMinMaxArray:  [TemperaturMinMax] = []
    var precipitation30DaysAccumulated: [Precipitation30DaysAccumulated] = []
    var averagePrecipitationOverYears: [PrecipitationOverYears] = []
    var averagePrecipitationNormalYears: [AveragePrecipitationNormalYears] = []
    var averageNormalPrecipitationMonth: [AverageNormalPrecipitationMonth] = []
    
    var normalJanuaryMin: Int = 0
    var normalFebruaryMin: Int = 0
    var normalMarsMin: Int = 0
    var normalAprilMin: Int = 0
    var normalMayMin: Int = 0
    var normalJuneMin: Int = 0
    var normalJulyMin: Int = 0
    var normalAugustMin: Int = 0
    var normalSeptemberMin: Int = 0
    var normalOctoberMin: Int = 0
    var normalNovemberMin: Int = 0
    var normalDecemberMin: Int = 0
    
    var normalJanuaryMax: Int = 0
    var normalFebruaryMax: Int = 0
    var normalMarsMax: Int = 0
    var normalAprilMax: Int = 0
    var normalMayMax: Int = 0
    var normalJuneMax: Int = 0
    var normalJulyMax: Int = 0
    var normalAugustMax: Int = 0
    var normalSeptemberMax: Int = 0
    var normalOctoberMax: Int = 0
    var normalNovemberMax: Int = 0
    var normalDecemberMax: Int = 0
    
    var normalJanuaryPrecipitation: Int = 0
    var normalFebruaryPrecipitation: Int = 0
    var normalMarsPrecipitation: Int = 0
    var normalAprilPrecipitation: Int = 0
    var normalMayPrecipitation: Int = 0
    var normalJunePrecipitation: Int = 0
    var normalJulyPrecipitation: Int = 0
    var normalAugustPrecipitation: Int = 0
    var normalSeptemberPrecipitation: Int = 0
    var normalOctoberPrecipitation: Int = 0
    var normalNovemberPrecipitation: Int = 0
    var normalDecemberPrecipitation: Int = 0
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
    /// Min og maks gjennomsnittstemoeraturer
    ///
    var temperaturMinMaxArrayAverageMinTemp: Double?
    var temperaturMinMaxArrayAverageMaxTemp: Double?

}
