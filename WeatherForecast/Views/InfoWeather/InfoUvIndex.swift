//
//  InfoUvIndex.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/12/2022.
//

import SwiftUI

struct InfoUvIndex : View {
    
    var index: Int
    @Binding var dayArray : [Double]
    @Binding var weatherIcon : [WeatherIcon]
    
    @State private var info : String = ""
    @State private var max : Double = 0.00
    
    @State private var option1: EnumType = .number12
    
    @State private var text : String = String(localized: "The UV index of the World Health Organization (UVI) measures ultraviolet radiation. The higher the UVI, the greater the chance of skin damage, and the faster the damage can occur. UVI can give you the necessary information about when you should protect yourself from the sun, and when you should avoid staying outdoors. WHO recommends that you stay in the shade or use sunscreen, a hat or protective clothing when the level is 3 (moderate) or higher.")
    
    @State private var text1 : String = String(localized: "Low level all day.")
    
    @State private var text2 : String = String(localized: "Use sunscreen, a hat or protective clothing when the level is 3 (moderate) or higher.")
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(String(localized: "Now, ") + FormatDateToString(date: Date(), format: "HH:mm"))
                .fontWeight(.bold)
            
            if max < 3.00 {
                TextField("", text: $text1, axis: .vertical)
                    .lineLimit(10)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
            } else {
                TextField("", text: $text2, axis: .vertical)
                    .lineLimit(10)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
           }

            Text(String(localized: "About the UV-index"))
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(12)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
                .font(.footnote)
            
            Spacer()
        }
        .font(.subheadline)
        .frame(width: UIDevice.isIpad ? 490 : 350,
               height: UIDevice.isIpad ? 300 : 300)
        .task {
            max = dayArray.max()!
        }
    }
    
}

