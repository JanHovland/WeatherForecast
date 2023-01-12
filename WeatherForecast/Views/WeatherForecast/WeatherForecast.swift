//
//  WeatherForecastMain.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 20/07/2022.
//

/// https://www.youtube.com/watch?v=PAPgcSpSpcs

import SwiftUI
import CoreLocation
import WeatherKit
import CloudKit

// For å kunne bruke WeatherKit :

// Gå til "Info"
// Legg til ny Key: Privacy - Location When In Use Description Privacy
// Legg til ny Key: Privacy - Location Always and When In Use Usage Description
// Gå til "Signing & Capabilities" Legg til Capabilities legg til "WeatherKit"

// Gå til deceloper.apple.com og velg Certificates, Identifier & Profiles
// Under "Identifier" : Finn aktuell applicasjon og klikk på denne
// Sjekk at WeatherKit er valgt i både "Capabilities" og "App Services"
// Dette kan ta opptil 30 minutter

/// https://word-brain.net/no/rev/id-507.html
/// https://blog.prototypr.io/ios-16-for-product-designers-and-design-engineers-38b5f8408481

/// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
///

struct WeatherForecast: View {
    let weatherService = WeatherService.shared
    
    @StateObject var locationManager = LocationManager()
    @StateObject var currentWeather = CurrentWeather()
    
    @State private var weather : Weather?
    @State private var currentPlace = String()
    @State private var geoRecord = GeoRecord()
//    @State private var newPlace = String()
    @State private var location = CLLocation()
    @State private var indicatorShowing = false
    @State private var opacity: Double = 0.0
    
    /// Inneholder soloåågang og solnedgang for 10 dager:
    ///
    @State private var sunRises: [String] = Array(repeating: "", count: 10)
    @State private var sunSets: [String] = Array(repeating: "", count: 10)
    
    var body: some View {
        VStack {
            ActivityIndicator(opacity: $opacity)
                .offset(y: UIDevice.isIpad ? -375 : -325)
            if let weather {
                HStack {
                    Button {
                        /// Rutine for å friske opp:
                        ///
                        Task.init {
                            await refresh()
                        }
                    } label: {
                        Image(systemName: "network")
                            .renderingMode(.original)
                            .font(.system(size: 30, weight: .light))
                    }
                    Spacer()
                    Text(geoRecord.place)
                        .font(.system(size: 40, weight: .light))
                    Spacer()
                    Button {
                        /// Rutine for å fsøke etter et sted
                        ///
                        Task.init {
                            FindNewPlace()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .font(.system(size: 30, weight: .light))
                    }
                }
                .padding()
                if UIDevice.isIpad {
                    ScrollView(.vertical, showsIndicators: false) {
                        WeatherForecastDetail(weather: weather, geoRecord: geoRecord)
                        VStack {
                            HourOverview(weather: weather)
                            
                            Group {
                                HStack (spacing: 8) {
                                    /// Viser vindretning og hastighet:
                                    ///
                                    WindView(weather: weather)
                                    /// Viser føles som:
                                    ///
                                    FeelsLike()
                                    /// Viser luftfuktighet:
                                    ///
                                    Humidity()
                                    /// Viser sikten:
                                    ///
                                    Visibility(weather: weather)
                                }
                                HStack (spacing: 8) {
                                    /// Viser Uv indeksen:
                                    ///
                                    UvIndex(weather: weather)
                                    /// Viser regn de forrige 24 timene:
                                    ///
                                    Precipitation24h(weather: weather)
                                    /// Viser solen:
                                    ///
                                    Sun(weather: weather,
                                        sunRises: $sunRises,
                                        sunSets: $sunSets)
                                    /// Viser lufttrykket:
                                    ///
                                    AirPressure(weather: weather)
                                }
                            }

                            /// Viser oversikt pr. dag:
                            ///
                            DayOverview(weather: weather,
                                        sunRises: $sunRises,
                                        sunSets: $sunSets)
                        }
                    }
                } else if UIDevice.isiPhone {
                    ScrollView (.vertical, showsIndicators: false){
                        WeatherForecastDetail(weather: weather, geoRecord: geoRecord)
                        VStack {
                            HourOverview(weather: weather)
                            
                            Group {
                                HStack (spacing: 8) {
                                    
                                    /// Viser vindretning og hastighet:
                                    ///
                                    WindView(weather: weather)
                                    /// Viser føles som:
                                    ///
                                    FeelsLike()
                                }
                                
                                HStack (spacing: 8) {
                                    /// Viser luftfuktighet:
                                    ///
                                    Humidity()
                                    /// Viser sikten:
                                    ///
                                    Visibility(weather: weather)
                                }
                            }
                            
                            Group {
                                HStack (spacing: 8) {
                                    /// Viser Uv indeksen:
                                    ///
                                    UvIndex(weather: weather)
                                    /// Viser regn de forrige 24 timene:
                                    ///
                                    Precipitation24h(weather: weather)
                                }
                                
                                HStack (spacing: 8) {
                                    /// Viser solen:
                                    ///
                                    Sun(weather: weather,
                                        sunRises: $sunRises,
                                        sunSets: $sunSets)
                                    /// Viser lufttrykket:
                                    ///
                                    AirPressure(weather: weather)
                                }
                            }

                            /// Viser oversikt pr. dag:
                            ///
                            DayOverview(weather: weather,
                                        sunRises: $sunRises,
                                        sunSets: $sunSets)
 
                        }
                    }
                }
                Spacer()
            }
        }
        .task (id: locationManager.currentLocation) {
            ///
            /// Finner currentLocation:
            ///
            let key = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
            let urlOpenCage = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
            if latitude == nil && longitude == nil {
                if let loc = locationManager.currentLocation {
                    location = loc
                    ///
                    /// Finner currentPlace på current position:
                    ///
                    latitude = locationManager.currentLocation?.coordinate.latitude as? Double // ?? 58.61730433715967
                    longitude = locationManager.currentLocation?.coordinate.longitude as? Double // ?? 5.644919460720766
                    geoRecord = await GetReverseGeoCode(latitude: latitude!,
                                                        longitude: longitude!,
                                                        key: key,
                                                        urlOpenCage: urlOpenCage)
                    currentPlace = geoRecord.formatted.description
                } else {
                    print("Unable to find location")
                }
            } else if latitude != nil && longitude != nil {
                ///
                /// Finner currentPlace:
                ///
                geoRecord = await GetReverseGeoCode(latitude: latitude!,
                                                    longitude: longitude!,
                                                    key: key,
                                                    urlOpenCage: urlOpenCage)
                currentPlace = geoRecord.formatted.description
            } else {
                print("Check latitude og longitude.")
            }
            ///
            /// Henter værdata:
            ///
            await refresh()
            
        }
        .environmentObject(currentWeather)
    } /// var Body
    
    /// Func for å finne været på et annet sted:
    ///
    func FindNewPlace() {
        Task {
            // newPlace = ""
            print("Find a new place...")
        }
    }
    
    /// Rutine for oppfriskning:
    ///
    func refresh() async {
        /// Finner soloppgang og solnedgang:
        ///
        let offset = OffsetFromUTC()
        let url = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
        let value : (String, [String], [String]) =
        await FindSunUpDown(url: url,  
                            offset: offset,
                            days: 10)
        if value.0.isEmpty {
            sunRises = value.1
            sunSets = value.2
        }
        else {
            sunRises.removeAll()
            sunSets.removeAll()
        }
         /// Starter visning av indicatoren :
        ///
        indicatorShowing = true
        opacity = 1.0
        /// Resetter weather:
        ///
        weather = nil
        do {
            self.weather = try await weatherService.weather(for: location)
            if let weather {
                /// Oppdaterer currentWeather:
                ///
                currentWeather.date = weather.currentWeather.date
                currentWeather.hour = Int(FormatDateToString(date: currentWeather.date, format: ("HH")))!
                currentWeather.cloudCover = weather.currentWeather.cloudCover
                currentWeather.condition = weather.currentWeather.condition.description
                currentWeather.symbolName = weather.currentWeather.symbolName
                currentWeather.dewPoint = weather.currentWeather.dewPoint.value
                currentWeather.humidity = weather.currentWeather.humidity
                currentWeather.pressure = weather.currentWeather.pressure.value
                currentWeather.isDaylight = weather.currentWeather.isDaylight
                currentWeather.temperature = weather.currentWeather.temperature.value
                currentWeather.apparentTemperature = weather.currentWeather.apparentTemperature.value
                currentWeather.uvIndex = weather.currentWeather.uvIndex.value 
                currentWeather.visibility = weather.currentWeather.visibility.value
                currentWeather.windSpeed = weather.currentWeather.wind.speed.value
                currentWeather.windGust = weather.currentWeather.wind.gust?.value ?? 0.00
                currentWeather.windDirection = weather.currentWeather.wind.direction.value
            }
        } catch {
            debugPrint(error)
        }
        indicatorShowing = false
        opacity = 0.0
    }
}


















