//
//  SunRiseOrSet.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 22/02/2023.
//

// import Foundation
import SwiftUI

struct SunRiseOrSet: View {
    
    let option: EnumType
    let date: Date
    let sunTime: [String]
    
    @Environment(WeatherInfo.self) private var weatherInfo
    
    var body: some View {
        
        let start = Date()
        let end = date
        
        let idx = daysBetween(start: start, end: end)
        
        let sTime = sunTime[idx]
        let index = sTime.index(sTime.startIndex, offsetBy: 2)
        let hourDate = FormatDateToString(date: date, format: "HH", offsetSec: weatherInfo.offsetSec)
        let hourSun = String(sunTime[idx].prefix(upTo: index))
        
        if hourDate == hourSun {
            VStack {
                Text(FormatDateToString(date: date, format: "d MMM", offsetSec: weatherInfo.offsetSec))
                    .foregroundColor(.mint)
                    .font(.footnote)
                    .offset(y: UIDevice.isIpad ? -6.50 : -6.50)
                Text(sunTime[idx])
                    .font(.footnote)
                    .offset(y: UIDevice.isIpad ? -6.50 : -6.50)
                VStack {
                    if option == .sunrise {
                        Image(systemName: "sunrise.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("Sunrise")
                            .font(.footnote)
                            .offset(y: UIDevice.isIpad ? 10 : 10)
                    } else if option == .sunset {
                        Image(systemName: "sunset.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("Sunset")
                            .font(.footnote)
                            .offset(y: UIDevice.isIpad ? 10 : 10)
                    }
                }
                .offset(y: UIDevice.isIpad ? -6.5 : -6.5)
                Spacer()
            }
        }
    }
}



