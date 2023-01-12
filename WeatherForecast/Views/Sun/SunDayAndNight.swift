//
//  SunDayAndNight.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 08/11/2022.
//

import SwiftUI
import WeatherKit

struct SunDayAndNight: View {
    
    let factor: CGFloat
    let xMax: CGFloat
    let index : Int
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @State private var sunRise: CGFloat = 0.00
    @State private var sunSet: CGFloat = 0.00
    @State private var offset: CGFloat = 0.00

    var body: some View {
        VStack {
            HStack (alignment: .center, spacing: 1) {
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(.gray)
                    .frame(width: sunRise * factor, height: 8 )
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(.yellow)
                    .frame(width: (sunSet - sunRise) * factor , height: 8)
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(.gray)
                    .frame(width: sunRise * factor, height: 8)
            }
            .overlay (
                Circle()
//                    .stroke(currentWeather.isDaylight == true ? .orange : .secondary , lineWidth: 5)
                    .stroke(.orange , lineWidth: 4)
                    .fontWeight(.heavy)
                    ///_  Beregning av offset:
                    ///  Bredden: 0 til "xMax "med
                    ///  xMax /  24
                    ///
                    .padding(.leading, offset)
                ,alignment: .leading
            )
            .padding(.top, 65)
        }
        .onChange(of: index) { index in
            /// Oppdaterer "sunRise" og "sunSet" :
            ///
            if !sunRises.isEmpty {
                sunRise = FindHourToCGFloat(hour: sunRises[index])
                sunSet = FindHourToCGFloat(hour: sunSets[index])
                let hour = FormatDateToString(date: Date(), format: ("HH:mm"))
                ///  "xMax" vil markere sirkelen helt til høyre
                ///   24 er antall timer i døgnet
                ///
                offset = (FindHourToCGFloat(hour: hour) * xMax) / 24.0
            }
        }
        .task {
            /// Oppdaterer "sunRise" og "sunSet" :
            ///
            if !sunRises.isEmpty {
                sunRise = FindHourToCGFloat(hour: sunRises[index])
                sunSet = FindHourToCGFloat(hour: sunSets[index])
                let hour = FormatDateToString(date: Date(), format: ("HH:mm"))
                ///  "xMax" vil markere sirkelen helt til høyre
                ///   24 er antall timer i døgnet
                ///
                offset = (FindHourToCGFloat(hour: hour) * xMax) / 24.0
            }
        }
    }
}

