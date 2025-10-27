//
//  DayDetailInfo.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailInfo: View {
    
    var weather: Weather
    var option : EnumType
    @Binding var index : Int
    @Binding var dayArray: [Double]
    @Binding var weekdayArray: [String]
    @Binding var windInfo: [WindInfo]
    @Binding var tempInfo: [Temperature]
    @Binding var weatherIcon: [WeatherIcon]

    var body: some View {
        switch option {
            
        case .temperature :
            InfoTemperature(index: $index,
                            option: option,
                            dayArray : $dayArray,
                            tempInfo: $tempInfo,
                            weekdayArray: $weekdayArray)
            
        case .uvIndex :
            InfoUvIndex(index: index,
                        option: option,
                        dayArray : $dayArray,
                        weatherIcon: $weatherIcon,
                        weekdayArray: $weekdayArray)
            
        case .wind :
            InfoWind(index: index,
                     option: option,
                     dayArray : $dayArray,
                     windInfo : $windInfo,
                     weekdayArray: $weekdayArray)
            
        case .precipitation :
            InfoPrecipitation(weather: weather,
                              index: index,
                              dayArray : $dayArray,
                              windInfo : $windInfo,
                              weekdayArray: $weekdayArray)
            
        case .feelsLike :
            InfoFeelsLike(index: index,
                          option: option,
                          weather: weather,
                          weekdayArray: $weekdayArray)
            
        case .humidity:
            InfoHumidity(index: index,
                         weather: weather,
                         option: option,
                         weekdayArray: $weekdayArray)

        case .visibility :
            InfoVisibility(index: index,
                           dayArray : $dayArray,
                           weekdayArray: $weekdayArray,
                           weather: weather,
                           option: option)
            
        case .airPressure:
            InfoAirPressure(index: index,
                            weather: weather,
                            weekdayArray: $weekdayArray)
            
        default :
            Text(String(localized: "No info."))
        }
        
    }
}
