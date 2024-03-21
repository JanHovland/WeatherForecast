//
//  AverageTemperatureDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation

struct AverageTemperatureDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    @State private var info: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    let a = "+3"
                    let b = String(localized: " over the normal")
                    
                    VStack {
                        HStack {
                            Text("\(a) \(b)")
                                .font(.system(size: 30, weight: .bold))
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                        
                        let c = String(localized: "Normally the highest: ")
                        let d = "6"
                        
                        HStack {
                            Text("\(c) \(d)º ")
                                .fontWeight(.bold)
                                .opacity(0.50)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding()
                    
                    HStack {
                        Text("Chart")
                            .font(.system(size: 100, weight: .bold))
                    }
                    .padding()

                    HStack {
                        Text(String(localized: "Overview"))
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                    }
                    .padding()
 
                    HStack {
                        Text(info)
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text(String(localized: "Monthly averages"))
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                    }
                    .padding()

                    let c = String(localized: "Lowest daily average temperature for ")
                    let d = "mars"
                    let e = String(localized: " is ")
                    let f = "3"
                    let g = String(localized: "and highest daily average temperature is ")
                    let h = "5"
                    
                    HStack {
                        Text("\(c) \(d) \(e) \(f) º, \(g)º.")
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .onAppear {
            info = String(localized: "For ")
            info = info + "11. mars "
            info = info + String(localized: "the normal temperature is in between ")
            info = info + "0"
            info = info + String(localized: "º and ")
            info = info + "6"
            info = info + "º,"
            info = info + String(localized: " and normally the highest temperature is ")
            info = info + "5"
            info = info + String(localized: "º. Today's highest temperature is now ")
            info = info + "8"
            info = info + "º."
        }
    }
}
