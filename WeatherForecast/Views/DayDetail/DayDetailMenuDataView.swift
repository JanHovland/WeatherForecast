//
//  DayDetailMenuDataView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 31/12/2022.
//

import SwiftUI
import WeatherKit

struct DayDetailMenuDataView: View {
    
    let weather: Weather
    @Binding var index: Int
    @Binding var menuSystemName: String
    @Binding var menuTitle: String
    @Binding var arrayDayIcons: [String]
    @Binding var opacity: Double
    
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: menuSystemName)
                    .font(.system(size: 15))
                    .symbolRenderingMode(.multicolor)
                Image(systemName: "chevron.down")
                    .font(.system(size: 17))
            }
            .padding(4)
            .symbolRenderingMode(.hierarchical)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.secondary)
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .opacity(opacity == 1.00 ? 1.00 : 0.00)
        }
        .contextMenu()  {
            ///
            /// Kaller opp menyen:
            ///
            MenuContent(menuSystemName: $menuSystemName,
                        menuTitle: $menuTitle)
            .opacity(opacity == 1.00 ? 1.00 : 0.00)
        }
    }
}
