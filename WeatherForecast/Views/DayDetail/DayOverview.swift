    //
    //  DayOverview.swift
    //  WeatherForecast
    //
    //  Created by Jan Hovland on 15/10/2022.
    //

    ///
    /// Har funnet en feil ved :
    ///     * @State private var index : Int  gir:
    ///     ** The compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressins.
    ///
    ///     ** @State private var index : Int = 0 er OK
    ///

import SwiftUI
import WeatherKit

    ///
    /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
    ///

struct DayOverview: View {
    let weather : Weather
    @Binding var sunRises : [String]
    @Binding var sunSets : [String]
   
    @Environment(DateSettings.self) private var dateSettings
    @Environment(WeatherInfo.self) private var weatherInfo

    @State private var currentDate = Date()
    @State private var dateComponent = DateComponents()
    @State private var futureDate = Date()
    @State private var offsetDay = 2
    @State private var offsetHour = -1
    @State private var spacing : CGFloat = 0
    @State private var paddingTop : CGFloat = 0
    @State private var paddingLeading : CGFloat = 0
    
    @State private var detailView : Bool = false
    @State private var dayDetailHide: Bool = true

    @State private var dateString = ""
    @State private var symbolString = ""
    @State private var dateSelected = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("DAILY FORECAST")
                .font(UIDevice.isIpad ? .body : .footnote)
                .opacity(0.50)
                .padding(.leading,6)
                .padding(.top,10)
                .padding(.bottom, -5)
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (spacing: 7) {
                    ForEach(weather.dailyForecast, id: \.date) { dayItem in
                        VStack (spacing: spacing) {
                            Text(FormatDateToString(date: dayItem.date, format: "EEEE d MMM", offsetSec: weatherInfo.offsetSec).firstUppercased)
                                .foregroundColor(.cyan)
                                .padding(.top, 10)
                                ///
                                /// Viser image med .fill
                                ///
                            Image(systemName: ConvertImageToFill(image: dayItem.symbolName))
                                .modifier(ImageViewModifier(image: ConvertImageToFill(image: dayItem.symbolName)))
                                .font(.title3)
                                .frame(width: 10, height: 10)
                                ///
                                /// Viser temperaturen akkurat nå for den første datoen og de neste dagene:
                                ///
                            Text("\(Int(dayItem.highTemperature.value.rounded()))º")
                                .font(.caption)
                        }
                        .padding(10)
                        .onTapGesture {
                                /// Task.init starter hver gang ved hvert .onTapGesture:
                                ///
                            Task.init {
                                dateString = dayItem.date.formatted()
                                symbolString = dayItem.symbolName
                                    ///
                                    /// Må finne aktuelt valg:
                                    ///
                                dateSelected = FormatDateToString(date: dayItem.date, format: "d", offsetSec: weatherInfo.offsetSec)
                                detailView.toggle()
                            }
                        }
                        .fullScreenCover(isPresented: $detailView, content: {
                            DayDetail(weather: weather,
                                      dateSelected: $dateSelected,
                                      dayDetailHide: $dayDetailHide,
                                      sunRises: $sunRises,
                                      sunSets: $sunSets,
                                      dateSettings: dateSettings,
                                      ///
                                      /// Weather conditions = Værforhold
                                      ///
                                      // menuIcon: "cloud.sun.rain.fill",
                                      // menuTitle: String(localized: "Weather conditions"))
                                      ///
                                      /// Wind = Vind
                                      ///
                                      // menuIcon: "wind",
                                      // menuTitle: String(localized: "Wind"))
                                      ///
                                      /// Air pressure = Lufttrykk
                                      ///
                                      // menuIcon: "gauge.medium",
                                      // menuTitle: String(localized: "Air pressure"))
                                      ///
                                      /// UV-index = UV-indeks
                                      ///
                                      // menuIcon: "sun.max",
                                      // menuTitle: String(localized: "UV-index"))
                                      ///
                                      /// Rain = Nedbør
                                      ///
                                      // menuIcon: "drop",
                                      // menuTitle: String(localized: "Rain"))
                                      ///
                                      /// Feels like = Føles som
                                      ///
                                      menuIcon: "thermometer.medium",
                                      menuTitle: String(localized: "Feels like"))

                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity)
                        })
                    }
                    .listStyle(.sidebar)
                }
            }
        }
        .task {
                ///
                /// Oppdaterer bredden avhengig av on iPhone eller iPad:
                ///
            if UIDevice.isIpad {
                paddingTop = 60
                paddingLeading = 321.0
                spacing = 10
            } else {
                paddingTop = 0
                paddingLeading = 0
                spacing = 10
            }
        }
        .modifier(DayDetailBackground(dayLight: weather.currentWeather.isDaylight))
    }
}
