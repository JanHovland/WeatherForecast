//
//  AverageFirstView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI

struct AverageFirstView: View {
    
    @State private var isTemperature: Bool = false
    
    var body: some View {
        VStack {
            Text("Average Init")
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .background(
            RoundedRectangle(
                cornerRadius: 15,
                style: .continuous
            )
            .fill(Color(.lightGray).opacity(0.40))
        )
        .onTapGesture {
            isTemperature.toggle()
        }
        .sheet(isPresented: $isTemperature, content: {
            AverageView()
        })
    }
}
