//
//  WeatherForecast.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import SwiftUI
import CoreLocation
import WeatherKit
import CloudKit
import OSLog

///
///
/// Initialet logger = Logger(subsystem: "com.janhovland.WeatherForecast", category: "WeatherForecastMain")
///
///

var screenWidth: CGFloat = 0


let logger = Logger(subsystem: "com.janhovland.WeatherForecast", category: "WeatherForecastMain")

///
/// Oppretter global hourForcast
///
var hourForecast: Forecast<HourWeather>?
///
/// Oppretter global dailyForecast
///
var dailyForecast: Forecast<DayWeather>?

///
/// Globale data for dsgene de  siste 10 / 30 år
///
var averageYearsPerDayDataRecord = AverageDailyDataRecord(time: [""],
                                                          precipitationSum: [0.00],
                                                          temperature2MMin: [0.00],
                                                          temperature2MMax: [0.00])

///
/// Globale data de siste 30 dagerene
///
var average30DaysDataRecord = AverageDailyDataRecord(time: [""],
                                                     precipitationSum: [0.00],
                                                     temperature2MMin: [0.00],
                                                     temperature2MMax: [0.00])

var averageYearsPerHourDataRecord = AverageHourlyDataRecord(time: [""],
                                                            temperature2M: [0.00])

struct MyPlace: Identifiable {
    let id = UUID()
    let extPlaceName: String
    let extCountryName: String
    let extLatitude: Double
    let extLongitude: Double
    let extOffsetString: String
    let extOffsetSec: Int
    let extFlag: String
}

struct WeatherForecastMain: View {
    
    @Environment(WeatherInfo.self) private var weatherInfo
    @State private var places = [Place]()
    @State private var myPlaces = [MyPlace]()
    @State private var opacityIndicator: Double = 1.00
    @State private var indexSetDelete = IndexSet()
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false

    var body: some View {
        ActivityIndicator(opacity: $opacityIndicator)
        ///
        /// Ved å benytte NavigationStack ser applikasjonen lik ut både IPhone og iPad
        ///
        NavigationStack {
            List {
                NavigationLink(destination: WeatherForecastSearchPlace()) {
                    Label {
                        Text("Search ...")
                            .opacity(0.50)
                    } icon: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ///
                /// Bruker local offsetString
                /// Bruker local offsetSec
                ///
                NavigationLink(destination: WeatherForecast(expOption: .intern,
                                                            extPlaceName: weatherInfo.placeName,
                                                            extCountryName: weatherInfo.countryName,
                                                            extLatitude: weatherInfo.latitude ?? 0.00,
                                                            extLongitude: weatherInfo.longitude ?? 0.00,
                                                            extOffsetString: weatherInfo.localOffsetString,
                                                            extOffsetSec: weatherInfo.localOffsetSec)) {
                    HStack (spacing:20) {
                        Label {
                            Text("Local weatherForecast")
                        } icon: {
                            Image(systemName: "cloud.sun.rain.fill")
                                .font(.subheadline)
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                 }
                Section("My places") {
                    ScrollView (showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(myPlaces) { myPlace in
                                NavigationLink(destination: WeatherForecast(expOption: .selection,
                                                                            extPlaceName: myPlace.extPlaceName ,
                                                                            extCountryName: myPlace.extCountryName,
                                                                            extLatitude: myPlace.extLatitude ,
                                                                            extLongitude: myPlace.extLongitude ,
                                                                            extOffsetString: myPlace.extOffsetString,
                                                                            extOffsetSec: myPlace.extOffsetSec)) {
                                    
                                    Label {
                                        Text("\(myPlace.extPlaceName), \(myPlace.extCountryName)")
                                            .padding(.leading, 5)
                                            .foregroundStyle(.white)
                                    } icon: {
                                        Text(myPlace.extFlag)
                                            .font(.title)
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                            }
                        }
                    }
                    .frame(height: UIDevice.isIpad ? 275 : 230)
                }
                Section("Diverse") {
                    NavigationLink(destination: ShowFileView()) {
                        Label("Show files in Document Directory", systemImage: "filemenu.and.cursorarrow")
                    }
                    NavigationLink(destination: SettingView()) {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink(destination: ToDoView()) {
                        Label("To do", systemImage: "square.and.pencil.circle")
                    }
                    NavigationLink(destination: RefreshOffsetView()) {
                        Label("Refresh offset", systemImage: "hourglass.circle")
                    }
                    NavigationLink(destination: CountriesView()) {
                        Label("Countries overview", systemImage: "flag")
                    }
                    ///
                    /// Frisker opp stedene mine:
                    ///
                    ///
                    RefreshMyPlaces()
                        .onTapGesture {
                            Task.init {
                                await RefreshPlaces()
                            }
                        }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Menu", displayMode: .inline)
            ///
            ///  Viser meldingene:
            ///
            .alert(title, isPresented: $showAlert) {
            }
            message: {
                Text(message)
            }
        }
        .task {
            await RefreshPlaces()
        }
        .padding(.horizontal, 10)
    }
    
    func RefreshPlaces() async {
        ///
        /// Viser ActivityIndicator:
        ///
        opacityIndicator = 1.0
        /// Resetting:
        ///
        myPlaces.removeAll()
        places.removeAll()
        ///
        /// Finner alle stedene fra CloudKit
        ///
        let value: (Bool, [Place], LocalizedStringKey, LocalizedStringKey)
        await value = FindAllPlaces()
        if value.0 == true {
            places = value.1
         } else {
            places.removeAll()
        }
        ///
        /// Oppdaterer myPlaces som inneholder alle stedene jeg har lagt inn i CloudKit:
        ///
        let count = places.count
        for i in 0..<count {
            let myPlace = MyPlace(extPlaceName: places[i].place,
                                  extCountryName: places[i].country,
                                  extLatitude: places[i].lat ?? 0.00,
                                  extLongitude: places[i].lon ?? 0.00,
                                  extOffsetString: places[i].offsetString,
                                  extOffsetSec: places[i].offsetSec,
                                  extFlag: places[i].flag)
            myPlaces.append(myPlace)
        }
        ///
        /// Skjuler ActivityIndicator:
        ///
        opacityIndicator = 0.0
    }
}

struct RefreshMyPlaces: View {
    var body: some View {
        Label {
            Text("Refresh my places")
        } icon: {
            Image(systemName: "mappin.circle")
        }
    }
}

