//
//  fileExist.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/11/2024.
//

import SwiftUI

func fileExist(named fileName: String) -> (LocalizedStringKey, Bool) {
    var errorMessage: LocalizedStringKey = ""
    var exist = false
    
    let fileManager = FileManager.default
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // Check if file exists before deleting
        if fileManager.fileExists(atPath: fileURL.path) {
            exist = true
        } else {
            errorMessage = "File does not exist."
        }
    }
    return (errorMessage, exist)
}



