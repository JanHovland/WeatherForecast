//
//  FindSizeOfView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/02/2024.
//

import SwiftUI

struct FindSizeOfView: View {
    var body: some View {
        // Pass GeometryProxy to a function
        GeometryReader { geometry in
            self.createCustomView(geometry: geometry)
        }
    }
    
    func createCustomView(geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height
        
        return HStack {
            Spacer()
            Text("Width: \(Int(width))")
            Text("Height: \(Int(height))")
            Spacer()
        }
    }
}
