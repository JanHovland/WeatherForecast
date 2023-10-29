//
//  UvIndexShowValue.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/11/2022.
//

import SwiftUI
import WeatherKit

struct UvIndexShowCurrentValue: View {
    let weather : Weather
    
    var body: some View {
        VStack (alignment: .leading){
            let uvIndex = String(weather.currentWeather.uvIndex.value)
            Text(uvIndex)
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, 15) // -15)
            Text(UvIndexCurrentDescription(weather: weather))
                .padding(.leading, 15) // -20)
        }
        .padding(.leading, -60)
        .padding(.bottom, 10)
    }
}

