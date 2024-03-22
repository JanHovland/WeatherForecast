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
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                        }
                        
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
                    
                    HStack {
                        Text("Chart #1")
                            .font(.system(size: UIDevice.isIpad ? 100 : 50, weight: .bold))
                    }
                    .padding()
                    
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
                        Text(String(localized: "Monthly averages"))
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
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
                    
                    HStack {
                        Text("Chart #2")
                            .font(.system(size: UIDevice.isIpad ? 100 : 50, weight: .bold))
                    }
                    .padding()
                    
                    HStack {
                        Text(String(localized: "About the normal range"))
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    let u = String(localized: "The normal range shows the most common temperature measurements for")
                    let v = "11"
                    let w = "mars"
                    let x = String(localized: "since")
                    let y = yearFromNormal
                    
                    HStack {
                        Text("\(u) \(v). \(w) \(x) \(y).\n")
                        Spacer()
                    }
                    
                    HStack {
                        Text(String(localized: "About normal temperatures"))
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    
                    let l = String(localized: "Normally the highest temperature is based on the average temperature for ")
                    let m = "11"
                    let n = "mars"
                    let o = String(localized: "every year since")
                    let p = yearFromNormal
                    HStack {
                        Text("\(l)\(m). \(n) \(o) \(p).")
                        Spacer()
                    }
                    
                    let q = String(localized: "Monthly averages reflect the highest and lowest daily temperatures since")
                    let r = yearFromNormal
                    let s = String(localized: "For example, the monthly average for January is based on measurements from 1 January to 31 January every year since")
                    let t = yearFromNormal
                    
                    HStack {
                        Text("\n\(q) \(r). \(s) \(t).")
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
