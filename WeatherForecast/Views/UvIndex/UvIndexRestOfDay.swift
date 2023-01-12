//
//  UvIndexRestOfDay.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 06/11/2022.
//

import SwiftUI
import WeatherKit

struct UvIndexRestOfDay: View {
    let weather : Weather
    var body: some View {
        VStack (alignment: .leading) {
            Text(UvIndexDescriptionRestOfDay(weather: weather))
                /// Fonten skaleres automatisk ned til 75%
                ///
                .minimumScaleFactor(0.75)
                .lineLimit(4)
        }
        .padding(.leading, -1)
        .padding(.bottom, -20)
    }
}

