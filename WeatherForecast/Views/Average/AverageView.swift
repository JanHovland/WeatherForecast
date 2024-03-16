//
//  AverageView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import WeatherKit

struct AverageView : View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("AVERAGES")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            
            Text("\(Int(currentWeather.apparentTemperature.rounded()))º")
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
            let a = averageMonthPrecification[2]
            Text("\(a)")
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
        }
        .onAppear{
            (averageMonthMin,
             averageMonthMax,
             averageMonthMean,
             averageMonthPrecification) = FindAverageYear(averageDailyTime: averageMonthlyDataRecord.time,
                                                          avarageDailyMin: averageMonthlyDataRecord.temperature2MMin,
                                                          avarageDailyMax: averageMonthlyDataRecord.temperature2MMax,
                                                          averageDailyMean: averageMonthlyDataRecord.temperature2MMean,
                                                          aveargePercification: averageMonthlyDataRecord.precipitationSum)
            logger.notice("averageMonthPrecification")

        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
