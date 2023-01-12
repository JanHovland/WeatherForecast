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
    @Binding var minMaxArray: [Double]
    @Binding var arrayDayIcons: [String]
    @Binding var selectedValue: String
    @Binding var hide: Bool
    
    var body: some View {
        if hide == false {
            VStack {
                HStack {
                    Image(systemName: menuSystemName)
                        .font(.system(size: 15))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 17))
                }
                .padding(4)
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.secondary)
                .background(Color(.systemGray5))
                .cornerRadius(15)
            }
            .contextMenu()  {
                ///
                /// Kaller opp menyen:
                ///
                MenuContent(menuSystemName: $menuSystemName,
                            menuTitle: $menuTitle)
            }
            .offset(x: UIDevice.isIpad ? 450 : 318,
                    y: UIDevice.isIpad ?   0 :   0)
            ///
            /// Viser dagens værdata avhengig av menuTitle:
            ///
            DayDetailWeatherData(weather: weather,
                                 menuTitle: $menuTitle,
                                 minMaxArray: $minMaxArray,
                                 index: $index,
                                 arrayDayIcons: $arrayDayIcons)
            .offset(x: UIDevice.isIpad ?  10   :  0,
                    y: UIDevice.isIpad ? -42.5 : -42.5)
        } else {
            Text(selectedValue)
                .font(.system(size: 22, weight: .bold))
                .padding(.bottom, 50)
                .offset(x: UIDevice.isIpad ?  230 : 170,
                        y: UIDevice.isIpad ?   10 :  10)
        }
    }
}

