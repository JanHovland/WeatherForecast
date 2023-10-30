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

///
/// https://word-brain.net/no/rev/id-507.html
///
/// https://blog.prototypr.io/ios-16-for-product-designers-and-design-engineers-38b5f8408481
///
/// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
///
/// https://www.andyibanez.com/posts/using-corelocation-with-swiftui/
///
/// https://useyourloaf.com/blog/xcode-13-missing-info.plist/
///
/// https://swiftuirecipes.com/blog/file-tree-with-expanding-list-in-swiftui
///
struct WeatherForecast: View {
    
    ///
    /// case intern                 /// Starte opp WeatherForecast() locationManager.currentLocation
    /// case selection            /// Starte opp WeatherForecast() fra WeatherForecastSelectPlace()
    ///
    
    
    /// @Enviroment(\.presentationMode) will be deprecated, use this instead: @Enviroment(\.dismiss) var dismissScreen and you will call it in the action of your button as a function, like this: dismissScreen().
    
    
    var expOption: EnumType = .intern
    var extPlaceName: String = ""
    var extCountryName: String = ""
    var extLatitude: Double = 0.00
    var extLongitude: Double = 0.00
    var extOffsetString: String = ""
    var extOffsetSec: Int = 0
    
    let weatherService = WeatherService.shared
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @Environment(\.dismiss) var dismissScreen
    
    @State private var weather : Weather?
    @State private var geoRecord = GeoRecord()
    @State private var opacityIndicator: Double = 1.00
    ///
    /// Inneholder soloppgang og solnedgang for 10 dager:
    ///
    @State private var sunRises: [String] = Array(repeating: "", count: 10)
    @State private var sunSets: [String] = Array(repeating: "", count: 10)
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    
    @State private var array: [Double] = Array(repeating: Double(), count: 24)
    
    @State private var persist: Bool = true
    
    var body: some View {
        VStack {
            ActivityIndicator(opacity: $opacityIndicator)
                .offset(y: UIDevice.isIpad ? -375 : -325)
            ///
            /// weatherInfo.offsetString settes til "" når et sted blir slettet.
            ///
            if weatherInfo.offsetString != ""  {
                if let weather {
                    if UIDevice.isIpad {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                VStack {
                                    Text(weatherInfo.placeName.count > 0 ? weatherInfo.placeName : "No placeName")
                                        .font(.system(size: 40, weight: .light))
                                    Text(weatherInfo.countryName.count > 0 ? weatherInfo.countryName : "No countryName")
                                }
                                ZStack {
                                    Image(systemName: "ellipsis.circle")
                                        .renderingMode(.original)
                                        .font(.system(size: 30, weight: .light))
                                        .contextMenu {
                                            ///
                                            /// Frisk opp:
                                            ///
                                            Button (action: {
                                                Task.init {
                                                    await Refresh()
                                                }
                                            }, label: {
                                                HStack {
                                                    Text("Refresh")
                                                    Image(systemName: "arrow.uturn.right.circle")
                                                }
                                            })
                                            ///
                                            /// Slette dette stedet:
                                            ///
                                            Button (action: {
                                                Task.init {
                                                    let place: Place = Place(place : weatherInfo.placeName,
                                                                             lon: weatherInfo.latitude,
                                                                             lat: weatherInfo.longitude)
                                                    var value: (Bool, LocalizedStringKey)
                                                    value = await DeleteOnePlace(place)
                                                    if value.0 == true {
                                                        title = "Delete a place"
                                                        message = value.1
                                                        showAlert.toggle()
                                                        ///
                                                        /// Sletter deler av weatherInfo:
                                                        ///
                                                        weatherInfo.latitude = 0.00
                                                        weatherInfo.longitude = 0.00
                                                        weatherInfo.placeName = ""
                                                        weatherInfo.countryName = ""
                                                        weatherInfo.offsetString = ""
                                                        weatherInfo.offsetSec = 0
                                                    } else {
                                                        title = "Delete a place"
                                                        message = value.1
                                                        showAlert.toggle()
                                                    }
                                                }
                                            }, label: {
                                                HStack {
                                                    Text("Delete this place")
                                                    Image(systemName: "x.circle")
                                                }
                                            })
                                        }
                                }
                                .offset(x:  350,
                                        y:  -54.0)
                                WeatherForecastDetail(weather: weather, geoRecord: geoRecord)
                                HourOverview(weather: weather,
                                             sunRises: $sunRises,
                                             sunSets: $sunSets)
                                Group {
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser vindretning og hastighet:
                                        ///
                                        WindView(weather: weather)
                                        ///
                                        /// Viser føles som:
                                        ///
                                        FeelsLike()
                                        ///
                                        /// Viser luftfuktighet:
                                        ///
                                        Humidity()
                                        ///
                                        /// Viser sikten:
                                        ///
                                        Visibility(weather: weather)
                                    }
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser Uv indeksen:
                                        ///
                                        UvIndex(weather: weather)
                                        ///
                                        /// Viser regn de forrige 24 timene:
                                        ///
                                        Precipitation24h(weather: weather)
                                        ///
                                        /// Viser solen:
                                        ///
                                        Sun(weather: weather,
                                            sunRises: $sunRises,
                                            sunSets: $sunSets)
                                        ///
                                        /// Viser lufttrykket:
                                        ///
                                        AirPressure(weather: weather)
                                    }
                                }
                                ///
                                /// Viser oversikt pr. dag:
                                ///
                                DayOverview(weather: weather,
                                            sunRises: $sunRises,
                                            sunSets: $sunSets)
                                ///
                                /// Viser historikken for været:
                                ///
                                WeatherForecastHistoryEurope(weather: weather)
                            }
                            .frame(width: 1200)
                        }
                    } else if UIDevice.isiPhone {
                        ScrollView (.vertical, showsIndicators: false) {
                            VStack {
                                VStack {
                                    Text(weatherInfo.placeName.count > 0 ? weatherInfo.placeName : "No placeName")
                                        .font(.system(size: 40, weight: .light))
                                    Text(weatherInfo.countryName.count > 0 ? weatherInfo.countryName : "No countryName")
                                }
                                ZStack {
                                    Image(systemName: "ellipsis.circle")
                                        .renderingMode(.original)
                                        .font(.system(size: 30, weight: .light))
                                        .offset(x:  170,
                                                y:  -55)
                                        .contextMenu {
                                            ///
                                            /// Frisk opp:
                                            ///
                                            Button (action: {
                                                Task.init {
                                                    await Refresh()
                                                }
                                            }, label: {
                                                HStack {
                                                    Text("Refresh")
                                                    Image(systemName: "arrow.uturn.right.circle")
                                                }
                                            })
                                            ///
                                            /// Slette dette stedet:
                                            ///
                                            Button (action: {
                                                Task.init {
                                                    let place: Place = Place(place : weatherInfo.placeName,
                                                                             lon: weatherInfo.latitude,
                                                                             lat: weatherInfo.longitude)
                                                    var value: (Bool, LocalizedStringKey)
                                                    value = await DeleteOnePlace(place)
                                                    if value.0 == true {
                                                        title = "Delete a place"
                                                        message = value.1
                                                        showAlert.toggle()
                                                        ///
                                                        /// Sletter deler av weatherInfo:
                                                        ///
                                                        weatherInfo.latitude = 0.00
                                                        weatherInfo.longitude = 0.00
                                                        weatherInfo.placeName = ""
                                                        weatherInfo.countryName = ""
                                                        weatherInfo.offsetString = ""
                                                        weatherInfo.offsetSec = 0
                                                       
                                                    } else {
                                                        title = "Delete a place"
                                                        message = value.1
                                                        showAlert.toggle()
                                                    }
                                                }
                                            }, label: {
                                                HStack {
                                                    Text("Delete this place")
                                                    Image(systemName: "x.circle")
                                                }
                                            })
                                        }                                }
                                WeatherForecastDetail(weather: weather, geoRecord: geoRecord)
                                HourOverview(weather: weather,
                                             sunRises: $sunRises,
                                             sunSets: $sunSets)
                                
                                Group {
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser vindretning og hastighet:
                                        ///
                                        WindView(weather: weather)
                                        ///
                                        /// Viser føles som:
                                        ///
                                        FeelsLike()
                                    }
                                    
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser luftfuktighet:
                                        ///
                                        Humidity()
                                        ///
                                        /// Viser sikten:
                                        ///
                                        Visibility(weather: weather)
                                    }
                                }
                                
                                Group {
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser Uv indeksen:
                                        ///
                                        UvIndex(weather: weather)
                                        ///
                                        /// Viser regn de forrige 24 timene:
                                        ///
                                        Precipitation24h(weather: weather)
                                    }
                                    
                                    HStack (spacing: 8) {
                                        ///
                                        /// Viser solen:
                                        ///
                                        Sun(weather: weather,
                                            sunRises: $sunRises,
                                            sunSets: $sunSets)
                                        ///
                                        /// Viser lufttrykket:
                                        ///
                                        AirPressure(weather: weather)
                                    }
                                }
                                ///
                                /// Viser oversikt pr. dag:
                                ///
                                DayOverview(weather: weather,
                                            sunRises: $sunRises,
                                            sunSets: $sunSets)
                                ///
                                /// Viser historikken for været:
                                ///
                                WeatherForecastHistoryEurope(weather: weather)
                            }
                        }
                    }
                    Spacer()
                }
            } 
        }
        .alert(title, isPresented: $showAlert) {
        }
        message: {
            Text(message)
        }
        .navigationBarTitleDisplayMode(.inline)
            ///
            /// SwiftUI gives us equivalents to UIKit’s viewDidAppear() and viewDidDisappear() in the form of onAppear() and onDisappear().
            ///
        .onAppear {
            Task.init {
                ///
                /// Sjekker innstillingene:
                ///
                let key1 = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
                let urlOpenCage1 = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
                let urlMetNo1 = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
                let urlOpenWeather1 = UserDefaults.standard.object(forKey: "UrlOpenWeather") as? String ?? ""

                if key1 == "" || urlOpenCage1 == "" || urlMetNo1 == "" || urlOpenWeather1 == "" {
                    title = "Missing data in one or more of the Settings.\n"
                    message = "Select Settings and enter the missing values."
                    showAlert.toggle()
                } else {
                    ///
                    /// Sjekker om internet er tilkoplet:
                    ///
                    var value : (Bool, LocalizedStringKey)
                    value = ConnectToInternet()
                    if value.0 == false {
                        title = value.1
                        message = "No Internet connection for this device."
                        showAlert.toggle()
                        ///
                        /// Lagger inn en forsinkelse på 10 sekunder:
                        ///
                        sleep(10)
                    }
                    ///
                    /// Kaller opp refresh()
                    ///
                    await Refresh()
                }
            }
        }
    }
    ///
    /// Rutine for oppfriskning:
    ///
    func Refresh() async {
        ///
        /// Starter visning av indicatoren :
        ///
        opacityIndicator = 1.0
        if expOption == .selection {
            ///
            /// Oppdaterer placeName, latitude og longitude:
            ///
            weatherInfo.latitude = extLatitude
            weatherInfo.longitude = extLongitude
            weatherInfo.placeName = extPlaceName
            weatherInfo.countryName = TranslateCountry(country: extCountryName)
            weatherInfo.offsetString = AdjustOffset(extOffsetString)
            weatherInfo.offsetSec = extOffsetSec
        } else {
            ///
            /// Finner currentLocation:
            ///
            let value1: (Double, Double, String, String, Int, Date, String, Double, Double, Double, Bool, String, String)
            value1 = await FindCurrentLocation()
            weatherInfo.latitude = value1.0
            weatherInfo.longitude = value1.1
            weatherInfo.placeName = value1.2
            weatherInfo.countryName = TranslateCountry(country: value1.12)
            weatherInfo.offsetString = value1.3
            weatherInfo.offsetSec = value1.4
            ///
            /// Tar vare på de locale variable:
            ///
            weatherInfo.localLatitude = value1.0
            weatherInfo.localLongitude = value1.1
            weatherInfo.localPlaceName = value1.2
            weatherInfo.localOffsetString = value1.3
            weatherInfo.localOffsetSec = value1.4
            weatherInfo.localDate = value1.5
            weatherInfo.localCondition = value1.6
            weatherInfo.localTemperature = value1.7
            weatherInfo.localLowTemperature = value1.8
            weatherInfo.localHighTemperature = value1.9
            weatherInfo.localIsDaylight = value1.10
            weatherInfo.localFlag = value1.11
            weatherInfo.localCountry = TranslateCountry(country: value1.12)
            ///
            /// Sjekker om det kommer koordinater fra FindCurrentLocation:
            ///
            if weatherInfo.latitude == 0.00 && weatherInfo.longitude == 0.00 {
                persist = false
                title = "Missing coordinates from FindCurrentLocation()"
                message = "No coordinates found.\n\nPlease note that this alert will only show for a few seconds."
                showAlert.toggle()
                ///
                /// Lukker denne meldingen etter 10 sekunder:
                ///
                dismissAlert(seconds: 10)
            }
        }
        if persist == true {
            ///
            /// Finner hourForecast:
            ///
            let startDate = Date().setTime(hour: 0, min: 0, sec: 0)
            let endDate = (Calendar.current.date(byAdding: .day, value: 11, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            
            let location = CLLocation(latitude: weatherInfo.latitude ?? 0.00, longitude: weatherInfo.longitude ?? 0.00)
            
            do {
                hourForecast = try await WeatherService.shared.weather(for: location,
                                                                       including: .hourly(startDate: startDate!,
                                                                                          endDate: endDate!))
            } catch {
                debugPrint(error)
                title = "Error finding 'hourForecast'.\n\nExit the app."
                message = ServerResponse(error: error.localizedDescription)
                showAlert.toggle()
            }
            ///
            /// Sjekker om hourForecast ikke er tom:
            ///
            if hourForecast?.isEmpty == true {
                persist = false
                title = "Find the hourForecast data"
                message = "The hourForecast is empty.\n\nPlease note that this alert will only show for a few seconds and then the App will automatically shut down."
                showAlert.toggle()
                ///
                /// Lukker denne meldingen etter 10 sekunder:
                ///
                dismissAlert(seconds: 10)
            }
            ///
            /// Går bare videre dersom persist er true:
            ///
            if persist == true {
                ///
                /// Finner soloppgang og solnedgang:
                ///
                let url = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
                let value : (String, [String], [String]) =
                await FindSunUpDown(url: url,
                                    offset: weatherInfo.offsetString,
                                    days: 10,
                                    latitude: weatherInfo.latitude,
                                    longitude: weatherInfo.longitude,
                                    offsetSec: weatherInfo.offsetSec)
                if value.0.isEmpty {
                    sunRises = value.1
                    sunSets = value.2
                }
                else {
                    sunRises.removeAll()
                    sunSets.removeAll()
                }
                ///
                /// Gir melding og avslutter appen dersom sola data er tom :
                ///
                if sunRises.isEmpty == true || sunSets.isEmpty == true {
                    persist = false
                    title = "Find data for the the Sun"
                    message = "The Sun data is empty.\n\nPlease note that this alert will only show for a few seconds."
                    showAlert.toggle()
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                    dismissAlert(seconds: 10)
                }
                ///
                /// Går bare videre dersom persist er true:
                ///
                if persist == true {
                    ///
                    /// Finner AirQuality:
                    ///
                    let url1 = UserDefaults.standard.object(forKey: "UrlOpenWeather") as? String ?? ""
                    let (status, airQuality) : (String, AirQualityRecord) =
                    await FindAirQuality(url: url1,
                                         key: UserDefaults.standard.object(forKey: "KeyOpenWeather") as? String ?? "",
                                         latitude : weatherInfo.latitude ?? 0.00,
                                         longitude:  weatherInfo.longitude ?? 0.00)
                    ///
                    /// Resetter weather og oppdaterer currentWearher:
                    ///
                    weather = nil
                    do {
                        self.weather = try await weatherService.weather(for: location)
                        if let weather,
                           status == "" {
                            ///
                            /// Legger inn Airquality:
                            ///
                            /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
                            currentWeather.aqi = airQuality.aqi                           
                            ///  Сoncentration of CO (Carbon monoxide), μg/m3
                            currentWeather.co = airQuality.co
                            /// Сoncentration of NO (Nitrogen monoxide), μg/m3
                            currentWeather.no = airQuality.no
                            /// Сoncentration of NO2 (Nitrogen dioxide), μg/m3
                            currentWeather.no2 = airQuality.no2
                            /// Сoncentration of O3 (Ozone), μg/m
                            currentWeather.o3 = airQuality.o3
                            /// Сoncentration of SO2 (Sulphur dioxide), μg/m3
                            currentWeather.so2 = airQuality.so2
                            ///  Сoncentration of PM2.5 (Fine particles matter), μg/m3
                            currentWeather.pm2_5 = airQuality.pm2_5
                            /// Сoncentration of PM10 (Coarse particulate matter), μg/m3
                            currentWeather.pm10 = airQuality.pm10
                            /// Сoncentration of NH3 (Ammonia), μg/m3
                            currentWeather.nh3 = airQuality.nh3
                            ///  Date and time, Unix, UTC
                            currentWeather.dt = airQuality.dt
                            ///
                            /// Oppdaterer currentWeather:
                            ///
                            currentWeather.date = weather.currentWeather.date
                            currentWeather.hour = Int(FormatDateToString(date: currentWeather.date, format: ("HH"), offsetSec: weatherInfo.offsetSec))!
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
                        ///
                        /// Gir feilmelding og avslutter hvis weather == nil:
                        ///
                        else {
                            persist = false
                            title = "Find the weather data"
                            message = "The weather is empty.\n\nPlease note that this alert will only show for a few seconds."
                            showAlert.toggle()
                            ///
                            /// Lukker denne meldingen etter 10 sekunder:
                            ///
                            dismissAlert(seconds: 10)
                        }
                    } catch {
                        debugPrint(error)
                        title = "Error finding 'weather'"
                        message = ServerResponse(error: error.localizedDescription)
                    }
                }
                ///
                /// Skjuler ActivityIndicator:
                ///
                opacityIndicator = 0.0
            }
        }
    }
    
    func dismissAlert(seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            showAlert = false
        }
    }
    
}
