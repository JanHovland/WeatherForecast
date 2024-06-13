//
//  CollapsibleHeader.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 10/12/2023.
//

import SwiftUI

struct CollapsibleHeader: View {
    
    @Binding var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            isOn.toggle()
        }, label: {
            Image(systemName: isOn ? "chevron.up" : "chevron.down")
                .foregroundColor(.blue)
                .font(.title3)
        })
        .font(Font.caption)
        .foregroundColor(.accentColor)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .overlay(
            Text(title),
            alignment: .leading
        )
    }
}

