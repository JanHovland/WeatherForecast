//
//  WeatherForecastSelectCardView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/01/2023.
//

import SwiftUI

struct WeatherForecastSelectCardView: View {
    let place: Place
    var body: some View {
        VStack {
            Image("Cloud")
                .symbolRenderingMode(.multicolor)
                .resizable()
                .frame(height: UIDevice.isIpad ? 90 : 90)
                .clipped()
                .cornerRadius(20)
                .opacity(place.isDaylight == true ? 0.40 : 0.25)
                .overlay (
                    VStack (spacing: 10) {
                        HStack (spacing: UIDevice.isIpad ? 40 : 20) {
                            Text(place.place)
                                .font(UIDevice.isIpad ? .title : .title3)
                            Text(place.flag)
                                .font(.title2)
                            let country = TranslateCountry(country: place.country)
                            Text(country)
                                .font(UIDevice.isIpad ? .title2 : .body)
//                            Text(place.offsetString)
//                                .font(.footnote)
                            Spacer()
                            if place.condition.count > 0 {
                                Text("\(Int(place.temperature.rounded()))º")
                                    .font(UIDevice.isIpad ? .title2 : .title3)
                            }
                        }
                        HStack (spacing: 20) {
                            ///
                            /// Her må GetWeekDay() benyttes som **ikke tar hensyn til TimeZone(secondsFromGMT: offsetSec) i stedet for FormatDateToString()**
                            ///
                            ///  I tillegg må dato = getBaseDate() benyttes for det er datoene der offsetSec == 0
                            ///
                            Text(GetTimeFromDay(date: getBaseDate().adding(seconds: place.offsetSec), format: "HH:mm"))
                            if place.condition.count > 0 {
                                Text(place.condition)
                                    .font(UIDevice.isIpad ? .body : .footnote)
                                Spacer()
                                Text(String("H: \(Int(round(place.highTemperature))) º L: \(Int(round(place.lowTemperature))) º"))
                                    .font(UIDevice.isIpad ? .title2 : .body)
                            } else {
                                Spacer()
                            }
                        }
                    }
                    .fontWeight(.light)
                    .padding(.horizontal, UIDevice.isIpad ? 50 : 20)
                )
        }
        .padding(.bottom, -15)
    }
}

