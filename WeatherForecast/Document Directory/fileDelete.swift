//
//  fileDelete.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2024.
//

import SwiftUI

func fileDelete(_ fileName: String) {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    try? FileManager.default.removeItem(at: url)
}
