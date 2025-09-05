//
//  FindSizeOfView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/02/2024.
//

import SwiftUI

struct FindSizeOfView: View {
    
    @Environment(ScreenSize.self) private var screenSize
    
    var body: some View {
        GeometryReader { geometry in
            self.createCustomView(geometry: geometry)
        }
    }
    
    func createCustomView(geometry: GeometryProxy) -> some View {
        
        let width = geometry.size.width
        let height = geometry.size.height
        
        screenSize.screenWidth = geometry.size.width
        screenSize.screenHeight = geometry.size.height
        
        return HStack {
            Spacer()
            Text("Width: \(Int(width))")
            Text("Height: \(Int(height))")
            Spacer()
        }
        .padding(.top, 5)
    }
}
