//
//  fileLoadFilenames.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 05/12/2024.
//

import SwiftUI

func fileLoadFilenames() -> (LocalizedStringKey, [String]) {
    
    var fileNames: [String] = []
    var errorMessage: LocalizedStringKey = ""
    
    let fileManager = FileManager.default
    do {
        // Get the URL of the document directory
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        // Get all files in the directory
        let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
        // Extract the file names
        fileNames = files.map { $0.lastPathComponent }
    } catch {
        errorMessage = "\(error.localizedDescription)"
    }
    return (errorMessage, fileNames.sorted())
}
