//
//  ActivityIndicator.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI

struct ActivityIndicator: View {
    
    @Binding var opacity: Double
    
    ///
    ///  Opacity == 0.0 betyr at ProgressView() ikke spinner
    ///  Opacity == 1.0 betyr at ProgressView() spinner
    ///  
    var body: some View {
        VStack {
            ProgressView()
            .opacity(opacity)
            .controlSize(.large)
        }
    }
}

