//
//  Wind.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 07/10/2022. 
//

import SwiftUI
import WeatherKit

struct WindView : View {
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo

    
    @State private var showNewView = false
    @State private var dateSelected = ""
    @State private var dayDetailHide: Bool = true
    
    var body: some View {
        VStack {
            /// Viser overskriften for vind:
            ///
            HStack {
                Image(systemName: "wind")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("WIND")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            /// Viser beskrivelse av vinden:
            ///
            ZStack {
                Group {
                    /// Viser den ytre sirkelen:
                    ///
                    Circle()
                    .stroke(Color.mint,
                            style: StrokeStyle(lineWidth: 10,
                                               lineCap: .butt,
                                               lineJoin: .round,
                                               dash: [1, 10],
                                               dashPhase: 0.0))
                    .opacity(0.50)
                    .frame(width: 150, height: 150)
                    Image(systemName: "arrowtriangle.up.fill")
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 7, height: 7)
                        .font(.system(size: 10, weight: .light))
                        .padding(.top, -80)
                    Text("N")
                        .padding(.top, -70 )
                        .font(.headline)
                    /// Viser Øst:
                    ///
                    Text("E")
                        .padding(.leading, 120)
                        .font(.headline)
                    /// Viser Øst:
                    ///
                    Text("V")
                        .padding(.trailing, 120)
                        .font(.headline)
                    /// Viser Sør:
                    ///
                     Text("S")
                        .padding(.top, 120)
                        .font(.headline)
                }
                /// Bygger opp vindpilen:
                ///
                VStack (spacing: 0) {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .frame(width: 7, height: 7)
                    VStack (alignment: .center, spacing: 60) {
                        Rectangle()
                            .frame(width: 2, height: 41 )
                        Rectangle()
                            .frame(width: 2, height: 41 )
                    }
                    Image(systemName: "arrowtriangle.down.fill")
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 7, height: 7)
                        .font(.system(size: 12, weight: .light))
                }
                .foregroundColor(Color.primary)
                /// Roterer vindpilen:
                ///
                .rotationEffect(Angle(degrees: Double(weather.currentWeather.wind.direction.value)), anchor: .center)
                /// Konverterer vindhastighet fra km/t til m/s:
                ///
                let windSpeed = Double(weather.currentWeather.wind.speed.value * 1000 / 3600)
                /// Viser vindhastigheten:
                ///
                VStack {
                    Text(String(Int(windSpeed.rounded())))
                        .font(.system(size: 25, weight: .bold))
                    Text("m/s")
                }
            }
        }
        
        .contentShape(Rectangle())
        .onTapGesture {
            ///
            /// Må finne aktuelt valg:
            ///
            dateSelected = FormatDateToString(date: Date(), format: "d", offsetSec: weatherInfo.offsetSec)
            showNewView.toggle()
            
        }
        .fullScreenCover(isPresented: $showNewView) {
            
            DayDetail(weather: weather,
                      dateSelected: $dateSelected,
                      dayDetailHide: $dayDetailHide,
                      sunRises: $sunRises,
                      sunSets: $sunSets,
                      dateSettings: dateSettings)
            
        }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
    
}

