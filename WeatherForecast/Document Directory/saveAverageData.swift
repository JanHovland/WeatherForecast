//
//  saveAverageData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2024.
//

import SwiftUI

func saveAverageData(_ fileName: String, data: AverageDailyDataRecord) {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(data) {
        try? encoded.write(to: url)
    }
}
