//
//  loadAverageData.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2024.
//

import SwiftUI

func loadAverageData(_ fileName: String) -> AverageDailyDataRecord? {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    if let data = try? Data(contentsOf: url) {
        let decoder = JSONDecoder()
        return try? decoder.decode(AverageDailyDataRecord.self, from: data)
    }
    return nil
}
