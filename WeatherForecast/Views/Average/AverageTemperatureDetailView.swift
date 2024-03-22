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
                    let b = String(localized: "º over the normal")
                    
                    VStack {
                        HStack {
                            Text("\(a) \(b)")
                                .font(.system(size: 30, weight: .bold))
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                        
                        let c = String(localized: "Normally the highest: ")
                        let d = "5"
                        
                        HStack {
                            Text("\(c)\(d)º ")
                                .fontWeight(.bold)
                                .opacity(0.50)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                        HStack {
                            Text("Today highest")
                            Spacer()
                        }
                        
                        let e = "8"
                        HStack {
                            Text("\(e)º")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                        }
                        
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

                    let f = String(localized: "Lowest daily average temperature for ")
                    let g = "mars"
                    let h = String(localized: " is ")
                    let i = "3"
                    let j = String(localized: "and highest daily average temperature is ")
                    let k = "5"
                    
                    HStack {
                        Text("\(f) \(g)\(h)\(i)º, \(j)\(k)º.")
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
