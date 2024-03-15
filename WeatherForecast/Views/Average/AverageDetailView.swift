//
//  AverageDetailView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/03/2024.
//

import SwiftUI
import Foundation

struct AverageDetailView: View {
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack(spacing: UIDevice.isIpad ? 20 : 10) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.headline.weight(.regular))
                Text("Average")
                Spacer()
            }
            ZStack {
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
                }
            }
            .offset(y: UIDevice.isIpad ? -22.5 : -22.5)
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("sdfghjkløkjhgf")
                    Text("1sdfghjkløkjhgf")
                    Text("2sdfghjkløkjhgf")
                    Text("3sdfghjkløkjhgf")
                    Text("4sdfghjkløkjhgf")
                    Text("5sdfghjkløkjhgf")
                    Text("6sdfghjkløkjhgf")
                    Text("7sdfghjkløkjhgf")
                    Text("8sdfghjkløkjhgf")
                    Text("9sdfghjkløkjhgf")
                    Text("10sdfghjkløkjhgf")
                    Text("11sdfghjkløkjhgf")
                    Text("12sdfghjkløkjhgf")
                    Text("13sdfghjkløkjhgf")
                    Text("14sdfghjkløkjhgf")
                    Text("14sdfghjkløkjhgf")
                    
                    Spacer()
                }
                
            } /// ScrollView
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding()
        .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
    }
}
