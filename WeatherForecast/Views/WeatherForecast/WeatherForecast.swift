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

///
/// Kan kompileres med : Version 16.0 (16A242d)
///                 Version 16.1 beta (16B5001e)  
///

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
/// ttps://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
///
/// https://www.andyibanez.com/posts/using-corelocation-with-swiftui/
///
/// https://useyourloaf.com/blog/xcode-13-missing-info.plist/
///
/// https://swiftuirecipes.com/blog/file-tree-with-expanding-list-in-swiftui
///

///
///     How to use Unified logging:
///     import OSLog
///     let value = 12345
///     let logger = Logger(subsystem: "com.janhovland.WeatherForecast", category: "WeatherForecastMain")
///     logger.debug("The value is \(value, format: .)")
///

struct WeatherForecast: View {
    
    var expOption: EnumType
    var extPlaceName: String
    var extCountryName: String
    var extLatitude: Double
    var extLongitude: Double
    var extOffsetString: String
    var extOffsetSec: Int
    
    var weatherService = WeatherService.shared
    
    @Environment(CurrentWeather.self) private var currentWeather
    @Environment(WeatherInfo.self) private var weatherInfo
    
    @State private var weather : Weather?
    @State private var geoRecord = GeoRecord()
    @State private var opacityIndicator: Double = 1.00
    @State private var opacitySize: Double = 0.00
    ///
    /// Inneholder soloppgang og solnedgang for 10 dager:
    ///
    @State private var sunRises: [String] = Array(repeating: "", count: sizeArray10)
    @State private var sunSets: [String] = Array(repeating: "", count: sizeArray10)
    
    @State private var moonRecord = MoonRecord()
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    @State private var showAlertFile: Bool = false
    @State private var showDismissAlert: Bool = false
    @State private var showAlertCloudKit: Bool = false
    @State private var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var persist: Bool = true
    @State private var settingsMissing: Bool = false
    @State private var someSnow: Bool = false
    
    @State private var years: Int = 0
    
    let noPlaceName: String = String(localized: "No placeName")
    let noCountryName: String = String(localized: "No countryName")
    
    let wishToDelete: String = String(localized: "Do you want to delete")
    let wishToSave: String = String(localized: "Do you want to save")
    
    let addedDeleteMessage: LocalizedStringKey = "It can take some time until the place is deleted on CloudKit.\nSelect \"Refresh my places\""
    let addedSaveMessage: LocalizedStringKey = "It can take some time until the place is saved on CloudKit.\nSelect \"Refresh my places\""
   
    @State public var errorMessage: LocalizedStringKey = ""
    
    @State private var moonData: MoonData = MoonData(phaseName: "",
                                                     majorPhase: "",
                                                     phase: 0.00,
                                                     stage: "",
                                                     moonSign: "",
                                                     emoji: "",
                                                     illumination: "",
                                                     daysUntilNextFullMoon: 0,
                                                     moonrise: "",
                                                     moonset: "",
                                                     distance: 0.00,
                                                     fullMoon: "",
                                                     newMoon: "")
   
    var body: some View {
        VStack {
            if settingsMissing {
                SettingView()
            }
            ActivityIndicator(opacity: $opacityIndicator)
                .offset(y: UIDevice.isIpad ? -375 : -325)
            ///
            /// Finner høde og bredde avhengig av IPhone og iPad
            ///
            FindSizeOfView()
                .frame(maxWidth: .infinity,
                       maxHeight: 30)
                .modifier(DayDetailBackground(dayLight: weather?.currentWeather.isDaylight ?? false ))
                .offset(y: -30)
                ///
                /// Skjuler FindSizeOfView()
                ///
                .opacity(1.00)
            ///
            /// weatherInfo.offsetString settes til "" når et sted blir slettet.
            ///
            if  weatherInfo.offsetString != "" {
                if let weather {
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack {
                            WeatherForecastDetail(weather: weather, geoRecord: geoRecord)
                            ///
                            /// Viser eventuelt snøvarsel
                            ///
                            if someSnow == true {
                                SnowWarningView()
                            } else {
                                EmptyView()
                            }
                            ///
                            /// Viser dagsoversikten
                            ///
                            HourOverview(weather: weather,
                                         sunRises: $sunRises,
                                         sunSets: $sunSets)
                            ///
                            /// Viser gjennomsnitt
                            ///
                            AverageFirstView()
                            ///
                            /// Tilpasning til iPad
                            ///
                            if UIDevice.isIpad {
                                AppsForIPad(weather: weather,
                                            sunRises: $sunRises,
                                            sunSets: $sunSets)
                            }
                            ///
                            /// Tilpasning til iPhone
                            ///
                            if UIDevice.isiPhone {
                                AppsForIPhone(weather: weather,
                                              sunRises: $sunRises,
                                              sunSets: $sunSets)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .navigationTitle("\(weatherInfo.placeName) \(weatherInfo.countryName)")
                        .toolbar {
                            Button {
                                if weatherInfo.localPlaceName.count > 0 {
                                    ///
                                    /// Lagre det lokale stedet:
                                    ///
                                    Task.init {
                                        title = "Save"
                                        showAlertFile.toggle()
                                    }
                                } else {
                                    ///
                                    /// Slette et valgt sted
                                    ///
                                    Task.init {
                                        title = "Delete"
                                        showAlertFile.toggle()
                                    }
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        ///
        /// Oppdatering av stedene og sletting av et sted
        ///
        .alert(title, isPresented: $showAlertFile) {
            if title == LocalizedStringKey("Save") {
                Button("Save", role: .destructive) {
                    Task.init {
                        ///
                        /// Lagre et lokale stedet
                        ///
                        let place = Place(place: weatherInfo.localPlaceName,
                                          flag: weatherInfo.localFlag,
                                          country: weatherInfo.localCountry,
                                          lon: weatherInfo.localLongitude,
                                          lat: weatherInfo.localLatitude,
                                          offsetSec: weatherInfo.localOffsetSec,
                                          offsetString: weatherInfo.localOffsetString,
                                          dst: weatherInfo.localDst,
                                          zoneName: weatherInfo.localZoneName,
                                          zoneShortName: weatherInfo.localZoneShortName)
                        
                        let value: (Bool, LocalizedStringKey)
                        value = await SaveNewPlace(place)
                        if value.0 == true {
                            ///
                            /// Stedet er lagret
                            ///
                            title = "Save place"
                            message = "\nIt can take some time until the place is saved on CloudKit.\nSelect \"Refresh my places\""
                            showAlertCloudKit.toggle()
                        } else {
                            ///
                            /// Stedet ble ikke lagret:
                            ///
                            title = "Save place"
                            message = value.1
                            showAlertCloudKit.toggle()
                        }
                    }
                }
            } else {
                Button("Delete", role: .destructive) {
                    ///
                    /// Slette et sted
                    ///
                    Task.init {
                        let place: Place = Place(place : weatherInfo.placeName,
                                                 lon: weatherInfo.latitude,
                                                 lat: weatherInfo.longitude)
                        let (status, messageDelete) = await DeleteOnePlace(place)
                        if status == true {
                            title = "Delete"
                            message = addedDeleteMessage
                            showAlertCloudKit.toggle()
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
                            title = "Delete"
                            message = messageDelete
                            showAlertCloudKit.toggle()
                        }
                    }
                }
            }
        } message: {
            Text(message)
        }
        ///
        /// Avslutter appen
        ///
        .alert(isPresented: $showAlert) {
            Alert(title: Text(title),
                  message: Text(message),
                  dismissButton: .cancel(Text("Terminate this app")))
        }
        ///
        /// Avslutter appen med DismissAlert
        ///
        .alert(isPresented: $showDismissAlert) {
            Alert(title: Text(title),
                  message: Text(message),
                  dismissButton: .destructive(Text("Cancel"),
                  action: {
                        WeatherForecastApp().exitApp()
                  }
              ))
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
                    ///
                    /// Åpner SettingView()
                    ///
                    settingsMissing = true
                    opacityIndicator = 0.00
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
            /// Oppdaterer placeName, latitude ,  longitude og offest:
            ///
            weatherInfo.localLatitude = 0.00
            weatherInfo.localLongitude = 0.00
            weatherInfo.localPlaceName = ""
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
            let value1: (Double, Double, String, String, Int, Date, String, Double, Double, Double, Bool, String, String, Int, String, String)
            value1 = await FindCurrentLocation()
            weatherInfo.latitude = (value1.0 * 1000000).rounded() / 1000000
            weatherInfo.longitude = (value1.1 * 1000000).rounded() / 1000000
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
            weatherInfo.localDst = value1.13
            weatherInfo.localZoneName = value1.14
            weatherInfo.localZoneShortName = value1.15
            ///
            /// Sjekker om det kommer koordinater fra FindCurrentLocation:
            ///
            if weatherInfo.latitude == 0.00 && weatherInfo.longitude == 0.00 {
                let string = String(localized: "Cannot find the local coordinates.")
                title = "\n\n \(string) \(showMessageOnlyForAFewSeconds)"
                let string1 = String(localized: "No local coordinates found.")
                message = "\n\(string1)"
                showDismissAlert.toggle()
                persist = false
                 ///
                /// Lukker denne meldingen etter 10 sekunder:
                ///
                dismissAlert(seconds: 10)
            }
        }
        
        if persist == true {
                ///
                /// Finner keyRapidApi fra Settings()
                ///
            let urlRapidApi = UserDefaults.standard.object(forKey: "UrlRapidApi") as? String ?? ""
            if urlRapidApi == "" {
                let string = String(localized: "Url  key for RapidApi")
                title = "\n\n \(string) \(showMessageOnlyForAFewSeconds)"
                let string1 = String(localized: "No Rapid url key found.")
                message = "\n\(string1)"
                showDismissAlert.toggle()
                persist = false
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                dismissAlert(seconds: 10)
            }
            let apiKey = UserDefaults.standard.object(forKey: "KeyRapidApi") as? String ?? ""
            if apiKey == "" {
                let string = String(localized: "Api  key for RapidApi.")
                title = "\n\n \(string) \(showMessageOnlyForAFewSeconds)"
                let string1 = String(localized: "No Rapid api key found.")
                message = "\n\(string1)"
                showDismissAlert.toggle()
                persist = false
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                dismissAlert(seconds: 10)
            }
            
            let apiHost = UserDefaults.standard.object(forKey: "KeyRapidHost") as? String ?? ""
            if apiHost == "" {
                let string = String(localized: "Host  key for RapidApi.")
                title = "\n\n \(string) \(showMessageOnlyForAFewSeconds)"
                let string1 = String(localized: "No Rapid host key found.")
                message = "\n\(string1)"
                showDismissAlert.toggle()
                persist = false
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                dismissAlert(seconds: 10)
            }
                ///
                /// Finner findMoonData
                ///
            moonData = await findMoonData(date: formatDate(Date()),
                                          url: urlRapidApi,
                                          latitude: weatherInfo.latitude ?? 0.00,
                                          longitude: weatherInfo.longitude ?? 0.00,
                                          apiKey: apiKey,
                                          apiHost: apiHost,
                                          statusCode: false,
                                          prettyPrint: true,
                                          offsetSec: weatherInfo.offsetSec)
            ///
            /// Oppdaterer CurrentWeather
            ///
            if moonData.majorPhase == "Full Moon" && moonData.phase < 0.50 {
                currentWeather.moonPhase = moonData.majorPhase
                currentWeather.moonEmoji = "🌕"
            } else {
                currentWeather.moonPhase = moonData.phaseName
                currentWeather.moonEmoji = moonData.emoji
            }
            currentWeather.moonMajorPhase = moonData.majorPhase
            currentWeather.phase = moonData.phase
            currentWeather.stage = moonData.stage
            currentWeather.moonSign = moonData.moonSign
            currentWeather.moonIllumination = moonData.illumination
            currentWeather.moonrise = moonData.moonrise
            currentWeather.moonset = moonData.moonset
            currentWeather.daysToFullMoon = moonData.daysUntilNextFullMoon
            currentWeather.distanceToMoon = Int(moonData.distance)
            currentWeather.fullMoon = moonData.fullMoon
            currentWeather.newMoon = moonData.newMoon
        }
        
        if persist == true {
            ///
            /// Datoer for normalperioden
            ///
            Task.init {
                ///
                /// Finn 10 eller 30 år ut fra Setting
                ///
                var startDate: String = ""
                let use30Years = UserDefaults.standard.object(forKey: "Use30Years") as? Bool ?? false
                if use30Years == false {
                    startDate = startDate10Years
                    weatherInfo.startYear = "2011"
                    years = 10
                } else {
                    startDate = startDate30Years
                    weatherInfo.startYear = "1991"
                    years = 30
                }
                (errorMessage, averageYearsPerDayDataRecord) =
                await GetAverageDayWeather(option: .years,
                                           placeName: weatherInfo.placeName,
                                           years: years,
                                           startDate: startDate,
                                           endDate: endDateYears,
                                           lat: weatherInfo.latitude ?? 0.00,
                                           lon: weatherInfo.longitude ?? 0.00)
                ///
                /// Viser eventuelle feilmeldinger
                ///
                if errorMessage.stringKey?.count ?? 10 > 0 {
                    persist = false
                    let string = String(localized: "Cannot find the AverageData.")
                    title = "\(string) \(showMessageOnlyForAFewSeconds) \n"
                    message = errorMessage
                    showDismissAlert.toggle()
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                    dismissAlert(seconds: 10)
                } else {
                    persist = true
                }
            }
        }
        if persist == true {
            ///
            /// Finner snøfallet i perioden ut fra weather.dailyForecast
            /// Tatt bort pr. 25.09.2025
            ///
            
            /// Finner dailyForecast
            ///
            dailyForecast = nil
            
            // Sikrer gyldige koordinater
            guard let lat = weatherInfo.latitude,
                  let lon = weatherInfo.longitude else {
                await MainActor.run {
                    let string = String(localized: "Cannot find the local coordinates.")
                    title = "\n\n \(string) \(showMessageOnlyForAFewSeconds)"
                    // message = "\n" + String(localized: "No local coordinates found.")
                    message = "No local coordinates found."
                    showDismissAlert.toggle()
                    persist = false
                }
                dismissAlert(seconds: 10)
                return
            }
            let location = CLLocation(latitude: lat, longitude: lon)
            
            let date = Date().adding(seconds: weatherInfo.offsetSec)
            guard let startDate = date.setTime(hour: 0, min: 0, sec: 0),
                  let endDate = Calendar.current
                    .date(byAdding: .day, value: 10, to: startDate)?
                    .setTime(hour: 0, min: 0, sec: 0),
                  endDate > startDate else {
                await MainActor.run {
                    let string = String(localized: "Error building date range for 'dailyForecast'")
                    title = "\(weatherInfo.placeName) \n\n \(string) \(showMessageOnlyForAFewSeconds)"
                    message = ""
                    showDismissAlert.toggle()
                    persist = false
                }
                dismissAlert(seconds: 10)
                return
            }
            
            do {
                dailyForecast = try await WeatherService.shared.weather(for: location,
                                                                        including: .daily(startDate: startDate,
                                                                                          endDate: endDate))
            } catch {
                
                print(error as Any)
                
                let string = String(localized: "Error finding 'dailyForecast'")
                await MainActor.run {
                    title = "\(weatherInfo.placeName) \n\n \(string) \(showMessageOnlyForAFewSeconds)"
                    let msg = "\(error)"
                    message = ServerResponse(error: msg)
                    showDismissAlert.toggle()
                    persist = false
                }
                ///
                /// Lukker denne meldingen etter 10 sekunder:
                ///
                dismissAlert(seconds: 10)
            }
            if persist == true {
                ///
                /// Sjekker om dailyForecast inneholder noen verdier av snø > 0,00
                ///
                someSnow = false
                dailyForecast!.forEach  {
                    if $0.date >= startDate &&
                        $0.date <= endDate {
                        if $0.precipitationAmountByType.snowfallAmount.amount.value > 0.00 {
                            someSnow = true
                        }
                    }
                }
                ///
                /// Oppdaterer temperaturene for weatherInfo
                ///
                weatherInfo.lowTemperature = dailyForecast!.forecast[0].lowTemperature.value
                weatherInfo.highTemperature = dailyForecast!.forecast[0].highTemperature.value
            }
        }
        if persist == true {
            ///
            /// Finner hourForecast:
            ///
            let date = Date().adding(seconds: weatherInfo.offsetSec)
            let start = date.setTime(hour: 0, min: 0, sec: 0)
            let startDate = start?.adding(days: -2)
            let endDate = (Calendar.current.date(byAdding: .day, value: 10, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            
            let location = CLLocation(latitude: weatherInfo.latitude ?? 0.00, longitude: weatherInfo.longitude ?? 0.00)
            ///
            /// Finner hourForecast
            ///
            hourForecast = nil
            do {
                hourForecast = try await WeatherService.shared.weather(for: location,
                                                                       including: .hourly(startDate: startDate!,
                                                                                          endDate: endDate!))
            } catch {
                let string = String(localized: "Error finding 'hourForecast'.")
                title = "\(weatherInfo.placeName) \n\n \(string) \(showMessageOnlyForAFewSeconds)"
                let msg = "\(error)"
                message = ServerResponse(error: msg)
                showDismissAlert.toggle()
                persist = false
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
                sunRises.removeAll()
                sunSets.removeAll()
                let url = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
                let value : (LocalizedStringKey, [String], [String], Int, Int) =
                await FindSunUpDown(url: url,
                                    offset: weatherInfo.offsetString,
                                    days: 10,
                                    latitude: weatherInfo.latitude,
                                    longitude: weatherInfo.longitude,
                                    offsetSec: weatherInfo.offsetSec)
                
                ///
                /// Skriver ut eventuelle feilmeldinger
                ///
                if value.0.stringKey?.count ?? 10 > 0 {
                    let string = String(localized: "Cannot find sun data.")
                    title = "\(string) \(showMessageOnlyForAFewSeconds)\n"
                    message = value.0
                    showDismissAlert.toggle()
                    persist = false
                    ///
                    /// Lukker denne meldingen etter 10 sekunder:
                    ///
                    dismissAlert(seconds: 10)
                } else {
                    sunRises = value.1
                    sunSets = value.2
                    
                    currentWeather.sunRises = sunRises
                    currentWeather.sunSets = sunSets
                    
                    ///
                    /// Oppdatere lengden av dagen
                    ///
                    currentWeather.dayLength = value.3
                    currentWeather.dayIncrease = value.4

                }
                ///
                /// Går bare videre dersom persist er true:
                ///
                if persist == true {
                    ///
                    /// Finner AirQuality:
                    ///
                   let url1 = UserDefaults.standard.object(forKey: "UrlOpenWeather") as? String ?? ""
                    let (errorMessage, airQuality) : (LocalizedStringKey, AirQualityRecord) =
                    await FindAirQuality(url: url1,
                                         key: UserDefaults.standard.object(forKey: "KeyOpenWeather") as? String ?? "",
                                         latitude : weatherInfo.latitude ?? 0.00,
                                         longitude:  weatherInfo.longitude ?? 0.00)
                    ///
                    /// Skriver ut eventuelle feilmeldinger
                    ///
                    if errorMessage.stringKey?.count ?? 10 > 0 {
                        let string = String(localized: "Cannot find data for the Air Quality.")
                        title = "\(string) \(showMessageOnlyForAFewSeconds)\n"
                        message = errorMessage
                        showDismissAlert.toggle()
                        persist = false
                        ///
                        /// Lukker denne meldingen etter 10 sekunder:
                        ///
                        dismissAlert(seconds: 10)
                    }
                    
                    if persist == true {
                        ///
                        /// Resetter weather og oppdaterer currentWearher:
                        ///
                        weather = nil
                        do {
                            self.weather = try await weatherService.weather(for: location)
                            if let weather,
                               errorMessage == "" {
                                ///
                                /// Legger inn Airquality:
                                ///
                                /// Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
                                if airQuality.aqi == 1 {
                                    currentWeather.image = "aqi.low"
                                } else if airQuality.aqi == 2 {
                                    currentWeather.image = "aqi.medium"
                                } else if airQuality.aqi == 3 {
                                    currentWeather.image = "aqi.medium"
                                } else if airQuality.aqi == 4 {
                                    currentWeather.image = "aqi.high"
                                } else if airQuality.aqi == 5 {
                                    currentWeather.image = "aqi.high"
                                }
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
                                /// moonPhase
                                /// isMoonUp
                                currentWeather.isMoonUp = moonRecord.isMoonUp
                                /// isSunUp
                                currentWeather.isSunUp = moonRecord.isSunUp
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
                        } catch {
                            title = "Error finding 'weather'"
                            message = ServerResponse(error: error.localizedDescription)
                            showAlert.toggle()
                            ///
                            /// Lukker denne meldingen etter 10 sekunder:
                            ///
                            dismissAlert(seconds: 10)
                        }
                    } /// if persist == true
                } /// if persist == true
                
                ///
                /// Skjuler ActivityIndicator:
                ///
                opacityIndicator = 0.0
                ///
                /// Viser opacitySize
                ///
                opacitySize = 1.00
            } /// if persist == true
        }
    }
}

func dismissAlert(seconds: Double) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        WeatherForecastApp().exitApp()
    }
}


func translateMoonPhase(phase: String) -> String {
    var moonPhase: String = ""
    switch phase {
    case "Waxing crescent": moonPhase = String(localized: "Waxing crescent")
        default: moonPhase = phase
    }
    return moonPhase
}

