//
//  InfoVisibility.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/12/2022.
//

import SwiftUI

struct InfoVisibility: View {
    
    var index: Int
    @Binding var dayArray : [Double]
    @Binding var weekdayArray: [String]
    
    @State private var text : String = String(localized: "Visibility indicates how far away you can clearly see objects such as buildings or mountain peaks. It is a measure of the transparency of the air and does not take into account the amount of sunlight or obstacles in the field of vision. Visibility of 10 km or more is considered clear.")
    
    @State private var text1 : String = ""

    var body: some View {
        VStack (alignment: .leading) {
            Text(String(localized: "Daily overview"))
                .fontWeight(.bold)
            
            TextField("", text: $text1, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Text(String(localized: "About visibility"))
                .fontWeight(.bold)
            
            TextField("", text: $text, axis: .vertical)
                .lineLimit(10)
                .textFieldStyle(.roundedBorder)
                .disabled(true)
            
            Spacer()
        }
        .font(.subheadline)
        .frame(width: UIDevice.isIpad ? 490 : 350,
               height: UIDevice.isIpad ? 300 : 300)
        .onChange(of: dayArray) { dayArray in
            /// Bygger opp værmeldingen:
            ///
            text1 = Forecast(index: index,
                             dayArray: dayArray,
                             weekdayArray: weekdayArray)
        }
        .task {
            /// Bygger opp værmeldingen:
            ///
            text1 = Forecast(index: index,
                             dayArray: dayArray,
                             weekdayArray: weekdayArray)
        }
    }
}

/// Bygger opp værmeldingen:
///
private func Forecast(index: Int,
                      dayArray: [Double],
                      weekdayArray: [String]) -> String {

    var text : String = ""
    let min = dayArray.min()!
    let max = dayArray.max()!
    var weekDay: String = ""
    
    if index == 0 {
        text = String(localized: "Today the visibility")
    } else {
        text = String(localized: "On ")
        weekDay = TranslateDay(index: index, weekdayArray: weekdayArray)
        text = text + weekDay
        text = text + String(localized: " the visability is")
    }
    
    text =  text + (max >= 10.00 ? String(localized: " totally clear, from ") : String(localized: " from "))
    text = text + String(format: "%.f", min) + String(localized: " to ")
    text = text + String(format: "%.0f", max) + String(localized: " miles.")
    
    return text
}

