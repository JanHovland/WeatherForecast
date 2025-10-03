//
//  MoonInfo.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 03/10/2025.
//

import SwiftUI

struct MoonInfo: View {
    
    let heading : String
    let value: String
    
    var body: some View {
        HStack {
            HStack {
                Text(heading)
                Spacer()
            }
            HStack {
                Spacer()
                Text(value)
            }
        }
    }
}
