//
//  getDocumentDirectory.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/11/2024.
//

import Foundation

func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

