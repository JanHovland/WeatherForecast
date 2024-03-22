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
                    
                    let a = "+6,6"
                    let b = String(localized: " cm more than usual.")
                    
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
                        Text("Chart #1")
                            .font(.system(size: UIDevice.isIpad ? 100 : 60, weight: .bold))
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
                        Text("Chart #2")
                            .font(.system(size: UIDevice.isIpad ? 100 : 60, weight: .bold))
                    }
                    .padding()

                    HStack {
                        Text(String(localized: "About normal rainfall"))
                            .font(.system(size: 30, weight: .bold))
                        Spacer()
                    }
                    
                    let e = String(localized: "Normal rainfall is based on rainfall measurements since")
                    let f = "1994"
                    let g = String(localized: "When the precipitation falls as snow, the normal amount of precipitation is calculated based on the equivalent amount of liquid if the snow were melted into water, and not the snow depth.")
                    
                    HStack {
                        Text("\(e) \(f) \n\(g)")
                            .fontWeight(.bold)
                            .opacity(0.50)
                        Spacer()
                    }
                    
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
            info = info + ". "
            info = info + String(localized: "In the last 30 days, the total has fallen ")
            info = info + "183 mm."
        }
    }
}
