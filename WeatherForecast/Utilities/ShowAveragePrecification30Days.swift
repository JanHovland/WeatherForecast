//
//  ShowAveragePrecification30Days.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/03/2024.
//

import SwiftUI

struct ShowAveragePrecification30Days: View {
    var body: some View {
        VStack {
            Text("ShowAveragePrecification30Days")
        }
        .onAppear {
            let v = FindPrecipitationLast30Days(averageDataRecord: averageDataRecord,
                                                fromDays: -1, // 30
                                                toDays: -1,
                                                offset: -3600)
            logger.notice("FindPrecipitationLast30Days = \(v)")
            
            
            logger.notice("data from ShowAveragePrecification30Days() = \(averageDataRecord.time)")
            
            
        }
    }
    
}

