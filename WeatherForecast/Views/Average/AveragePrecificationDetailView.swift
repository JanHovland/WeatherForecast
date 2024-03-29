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
                    
                    let a = "+66"
                    let b = String(localized: " mm more than usual.")
                    
                    VStack {
                        HStack {
                            Text("\(a) \(b)")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                        }
   
                        let c = String(localized: "Average over 30 days: ")
                        let d = "117"
                        
                        HStack {
                            Text("\(c) \(d) mm")
                                .fontWeight(.bold)
                                .opacity(0.50)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                                        
                    HStack {
                        Text("Chart #1")
                            .font(.system(size: UIDevice.isIpad ? 100 : 50, weight: .bold))
                    }
                    .padding(.bottom, 10)

                    HStack {
                        Text(String(localized: "Overview"))
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.bottom, 10)
 
                    HStack {
                        Text(info)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Chart #2")
                            .font(.system(size: UIDevice.isIpad ? 100 : 50, weight: .bold))
                    }
                    .padding()
 
                    HStack {
                        Text(String(localized: "About normal rainfall"))
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    let e = String(localized: "Normal rainfall is based on rainfall measurements since")
                    let f = yearFromNormal
                    let g = String(localized: "When the precipitation falls as snow, the normal amount of precipitation is calculated based on the equivalent amount of liquid if the snow were melted into water, and not the snow depth.")
                    
                    HStack {
                        Text("\(e) \(f). \n\(g)")
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

/*
averageDailyTime[i].contains(monthSelected)


2024-02-20 til 2024-03-21

"2024-"
>= "-02-20" && <= "-03-21"
*/
