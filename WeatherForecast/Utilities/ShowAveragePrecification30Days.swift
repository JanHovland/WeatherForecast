//
//  ShowAveragePrecification30Days.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/03/2024.
//

import SwiftUI

struct ShowAveragePrecification30Days: View {
    
    @Environment(WeatherInfo.self) private var weatherInfo
    
    var body: some View {

        VStack {
            Text("ShowAveragePrecification30Days")
        }
        .onAppear {
            logger.notice("data from ShowAveragePrecification30Days() = \(averageDataRecord.time)")
            
            let v = FindPrecipitationLast30Days(averageDataRecord: averageDataRecord,
                                                offset: weatherInfo.offsetSec)
            
            logger.notice("FindPrecipitationLast30Days = \(v)")
            
            
            
            
        }
    }
    
}

