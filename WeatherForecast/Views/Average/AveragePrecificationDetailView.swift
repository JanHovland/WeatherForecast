//
//  AveragePrecificationDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/03/2024.
//

import SwiftUI
import Foundation

struct AveragePrecificationDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    @State private var info: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    let a = "+6,6 cm"
                    let b = String(localized: " more than usual.")
                    
                    VStack {
                        HStack {
                            Text("\(a) \(b)")
                                .font(.system(size: 30, weight: .bold))
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                        
                        let c = String(localized: "Average over 30 days: ")
                        let d = "11,6 cm"
                        
                        HStack {
                            Text("\(c) \(d)")
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
                        Text("Precification mars = \(averageMonthPrecification[2])")
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
            info = String(localized: "Normally it falls")
            info = info + "117 mm "
            info = info + String(localized: "precipitation from ")
            info = info + "10. februar"
            info = info + String(localized: " to ")
            info = info + "11. mars"
            info = info + " . "
            info = info + String(localized: "In the last 30 days, the total has fallen ")
            info = info + "183 mm."
        }
    }
}
