//
//  Visibility.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 09/10/2022.
//

import SwiftUI
import WeatherKit

struct Visibility : View {
    let weather: Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    @Environment(DateSettings.self) private var dateSettings
    
    @State private var showNewView = false
    @State private var dateSelected = ""
    @State private var dayDetailHide: Bool = true
    
    @State private var cloudCoverage = ""
    
    var body: some View {
        VStack {
            /// Viser overskriften for sikten:
            ///
            HStack {
                Image(systemName: "eye.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.headline.weight(.regular))
                Text("VISIBILITY")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
            }
            .opacity(0.50)
            /// Viser sikten:
            ///
            Text("\(Int((weather.currentWeather.visibility.value / 1000.00).rounded())) km")
                .font(.system(size: 40, weight: .light))
                .padding(.top, 10)
                .padding(.leading, -50)
            VStack (alignment: .leading){
                /// Beskrivelse av sikten:
                ///
                let s1 = String(localized: "It is")
                let s2 = String(localized: "now.")
                Text("\(s1) \(VisibilityDescription(weather: weather)) \(s2)")
                    .lineLimit(4)
                    .padding(.top, 10)
                    .padding(.leading, -15)
            }
            Spacer()
        }
            ///
            /// .contentShape() må ligge foran .onTapGesture
            ///
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
                          dateSettings: dateSettings,
                          ///
                          /// Visibility = Sikt
                          ///
                          menuIcon: "eye",
                          menuTitle: String(localized: "Visibility"))
            }
        .frame(maxWidth: .infinity,
               maxHeight: 180)
        .padding(15)
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}

func VisibilityDescription(weather: Weather) -> String {
    
    /// https://www.met.no/vaer-og-klima/begreper-i-vaervarsling
    ///
    /// Skyet vær og sikt
    ///
    /// Meteorologene deler skydekke opp i åttendedeler.
    /// Det er ulike begreper for skydekke etter hvor stor del av himillimeterelen som er dekket av skyer.
    /// Klart/ pent vær: 0-2 av 8
    /// Lettskyet: 1-3 av 8
    /// Delvis skyet: 3-5 av 8
    /// Skyet: 5-8 av 8
    ///
    /// Meteorologene har også en definert skala når de bruker ulike uttrykk for sikt.
    ///
    /// God sikt betyr sikt på mer enn 10 kilometer
    /// Moderat sikt er sikt på 4 - 10 kilometer
    /// Dårlig sikt er sikt på 1 - 4 kilometer
    /// Tåke gir sikt på mindre enn 1 kilometer
    
    let visibility = weather.currentWeather.visibility.value / 1000
    
    switch visibility {
    case 0.00...0.99  :
        return String(localized: "fog")
    case 1.00...3.99:
        return String(localized: "poor visibility")
    case 4.00...10.00:
        return String(localized: "moderate visibility")
    default:
        return String(localized: "clear weather")
    }
    
}

