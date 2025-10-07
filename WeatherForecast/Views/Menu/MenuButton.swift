//
//
//  MenuButton.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/10/2022.
//

import SwiftUI

struct MenuButton: View {
    
    @Binding var menuIcon : String
    @Binding var dayDetailHide: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: menuIcon)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 15))
                Image(systemName: "chevron.down")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 17))
            }
            .padding(4)
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(.primary)
            .background(Color(.systemGray5))
            .cornerRadius(15)
        }
        .task {
            dayDetailHide = false
        }
    }
}
