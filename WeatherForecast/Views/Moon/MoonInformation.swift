//
//  MoonInformation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/09/2025.
//

import SwiftUI

struct MoonInformation: View {
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            ZStack {
//                HStack {
//                    Image(systemName: image)
//                        .symbolRenderingMode(.multicolor)
//                        .font(Font.headline.weight(.regular))
//                    Spacer()
//                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
                                .padding(.trailing, 20)
                       })
                    }
                    .padding(.top, 20)
                }
            }
            
            Text(currentWeather.moonEmoji)
                .font(.system(size: 130))
            
            Text(String(format: NSLocalizedString(currentWeather.moonPhase, comment: "")))
                
            
            
            
                // Color.green.opacity(0.3).ignoresSafeArea()
//            Color("Background#01")
//                .opacity(0.35)
//                .ignoresSafeArea()
            
                 
            
            Spacer()
                 
                
            
        }
        // .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
     }
}
