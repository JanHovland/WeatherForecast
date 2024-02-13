//
//  SunDayAndNight.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/11/2022.
//

import SwiftUI
import WeatherKit

///
/**
 Another useful function
 - parameters:
 /**
  Another useful function
  - parameters:
    - alpha: Describe the alpha param
    - beta: Describe the beta param
  - Attention: Watch out for this!
  - Author: Tim Cook
  - Authors:
    John Doe
    Mary Jones
  - Bug: This may not work
  - Complexity: O(log n) probably
  - Copyright: 2016 Acme
  - Date: Jan 1, 2016
  - experiment: give it a try
  - important: know this
  - invariant: something
  - Note: Blah blah blah
  - Precondition: alpha should not be nil
  - Postcondition: happy
  - Remark: something else
  - Requires: iOS 9
  - seealso: something else
  - Since: iOS 9
  - Todo: make it faster
  - Version: 1.0.0
  - Warning: Don't do it */*/
struct SunDayAndNight: View {
    
    let xMax: CGFloat
    /// Bredden av den grå linjen
    let index : Int
    /// Akuell index, fra 0 til 9
    @Binding var sunRises : [String]
    /// Soloppgang i 10 dagers perioden
    @Binding var sunSets : [String]
    /// Solnedgang i 10 dagers perioden
    
    @State private var sunRise: CGFloat = 0.00
    @State private var sunSet: CGFloat = 0.00
    @State private var offset: CGFloat = 0.00
    @State private var offset1: CGFloat = 0.00
    @State private var time: String = ""
    @State private var width: CGFloat = 0.00
    
    @Environment(WeatherInfo.self) private var weatherInfo

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .fill(.gray)
                .frame(width: xMax, height: 8 )
                .overlay {
                    VStack (alignment: .leading) {
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(.yellow)
                            .frame(width: width, height: 8 )
                    }
                    .offset(x: offset)
                }
        }
        .overlay {
            Circle()
                .stroke(.orange , lineWidth: 4)
                .fontWeight(.heavy)
                .offset(x: offset1)
                .opacity(index == 0 ? 1.00 : 0.00)
        }
        .onAppear {
            ///
            /// Oppdaterer "sunRise" og "sunSet" :
            ///
            if !sunRises.isEmpty {
                ///
                /// FindHourToCGFloat() endrer f.eks. 7.40 til 7.67:
                ///
                sunRise = FindHourToCGFloat(hour: sunRises[index])
                sunSet = FindHourToCGFloat(hour: sunSets[index])
                ///
                /// Beregner bredden på den grå linjen
                ///
                width = (sunSet - sunRise) * (xMax / 24)
                ///
                /// Beregner når solen starter:
                ///
                let factor = xMax / 24
                let x = (xMax - width) / 2             /// Anstand til start av "dagen"
                let y = sunRise * factor               /// Posisjonen til "sunRise"
                offset = y - x                         /// Offset = y - x (viser hvor den gule linjen starter)
                ///
                /// Må finne aktuelt klokkeslett:
                ///
                
                time = GetTimeFromDay(date: getBaseDate().adding(seconds: weatherInfo.offsetSec), format: "HH:mm")
                
                let positionOfClock = FindHourToCGFloat(hour: time) * factor
                ///
                /// Plasserer Circle() på linjen
                ///
                if positionOfClock == xMax / 2 {                /// Klokken er 12:00 = midt på den gule linjen
                    offset1 = 0
                } else if positionOfClock < (xMax / 2) {        /// Klokken er før 12:00
                    offset1 = -((xMax / 2) - positionOfClock)
                } else if positionOfClock > (xMax / 2) {        /// Klokken er etter 12:00
                    offset1 = positionOfClock - (xMax / 2)
                }
            }
        }
        .onChange(of: index) { oldIndex, index in
            ///
            /// Oppdaterer "sunRise" og "sunSet" :
            ///
            if !sunRises.isEmpty {
                ///
                /// FindHourToCGFloat() endrer f.eks. 7.40 til 7.67:
                ///
                sunRise = FindHourToCGFloat(hour: sunRises[index])
                sunSet = FindHourToCGFloat(hour: sunSets[index])
                ///
                /// Beregner bredden på den grå linjen
                ///
                width = (sunSet - sunRise) * (xMax / 24)
                ///
                /// Beregner når solen starter:
                ///
                let factor = xMax / 24
                let x = (xMax - width) / 2             /// Anstand til start av "dagen"
                let y = sunRise * factor               /// Posisjonen til "sunRise"
                offset = y - x                         /// Offset = y - x (viser hvor den gule linjen starter)
            }
        }
    }
}
