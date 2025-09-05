//
//  ShowFileView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2024.
//

import SwiftUI

struct ShowFileView: View {
    
    @State private var fileNames: [String] = []
    
    var body: some View {
        Text("Files in Document Directory")
        if fileNames.count == 0 {
            Text("No files in Document Directory")
                .foregroundStyle(.red)
                .padding(.vertical, 60)
        }
        List {
            ForEach (fileNames, id: \.self) { fileName in
                Text(fileName)
                    .font(UIDevice.isIpad ? .system(.body) : .system(.footnote))
            }
            .onDelete(perform: findFileToDelete)
        }
        .onAppear {
            var value: (LocalizedStringKey, [String])
            
            value = fileLoadFilenames()
            
            if value.0 == "" {
                fileNames = value.1
            }
        }
    }
    
    func findFileToDelete(at indexSet: IndexSet) {
        for index in indexSet {
            let fileName = fileNames[index]
            fileDelete(fileName)
         }
    }
}

