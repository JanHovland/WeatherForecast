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
/// ttps://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
///
/// https://www.andyibanez.com/posts/using-corelocation-with-swiftui/
///
/// https://useyourloaf.com/blog/xcode-13-missing-info.plist/
///
/// https://swiftuirecipes.com/blog/file-tree-with-expanding-list-in-swiftui
///

///
//*     How to use Unified logging:
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
    @State private var showAlertCloudKit: Bool = false
    @State private var array: [Double] = Array(repeating: Double(), count: sizeArray24)
    @State private var persist: Bool = true
    @State private var settingsMissing: Bool = false
    @State private var someSnow: Bool = false
    
    let noPlaceName: String = String(localized: "No placeName")
    let noCountryName: String = String(localized: "No countryName")
    
    let wishToDelete: String = String(localized: "Do you want to delete")
    let wishToSave: String = String(localized: "Do you want to save")
    
    let addedDeleteMessage: LocalizedStringKey = "It can take some time until the place is deleted on CloudKit.\nSelect \"Refresh my places\""
    let addedSaveMessage: LocalizedStringKey = "It can take some time until the place is saved on CloudKit.\nSelect \"Refresh my places\""
   
    @State public var errorMessage: LocalizedStringKey = ""
    
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
                .opacity(0.00)
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
                            /// Viser Gjennmsnitt (må legges inn i tilpasningene senere
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
        /// Status for lagring på CloudKit
        ///
        .alert(title, isPresented: $showAlertCloudKit) {
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
                    ///  Dette virker kun på iPhone !!!!!
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
                persist = false
                title = "Missing coordinates from FindCurrentLocation()"
                message = "No coordinates found."
                showAlert.toggle()
            }
        }
//        if persist == true {
//            ///
//            /// Resetting av data
//            ///
//            averageMonthlyDataRecord.time.removeAll()
//            averageMonthlyDataRecord.precipitationSum.removeAll()
//            averageMonthlyDataRecord.temperature2MMin.removeAll()
//            averageMonthlyDataRecord.temperature2MMax.removeAll()
//            averageMonthlyDataRecord.temperature2MMean.removeAll()
//            
//            ///
//            /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31
//            ///
//            ///     Ny normal i klimaforskningen:
//            ///     16.12.2020 | Endret 18.1.2021
//            ///     Fra 1. januar 2021 blir 1991-2020 den nye perioden vi tar 
//            ///     utgangspunkt i når vi snakker om hva som er normalt vær.
//            ///     Tidligere har vi brukt 1961-1990.
//            ///     Hvorfor bytter vi normalperiode?
//            ///     I 1935 ble det enighet i Verdens meteorologiorganisasjon (WMO) 
//            ///     om at en trengte en felles referanse for klima,
//            ///     såkalte standard normaler.
//            ///     De ble enige om at hver periode skulle vare 30 år.
//            ///     På den måten sikret man en lang nok dataperiode, men unngikk påvirkning
//            ///     fra kortvarige variasjoner.
//            ///     Den første  normalperioden skulle gå fra 1901 - 1930.
//            ///     Det ble også enighet om at normalene skulle byttes hvert 30. år.
//            ///     I 2014 vedtok WMO sin Klimakommisjon at normalene fortsatt skal dekke 30 år,
//            ///     men nå skal byttes hvert 10. år på grunn av klimaendringene.
//            ///     Klimaet i dag endrer seg så mye at normalene i slutten av perioden ikke lenger 
//            ///     reflekterer det vanlige været i et område.
//            ///     Når klimaet endrer seg raskt, slik det gjør nå, må vi endre normalene hyppigere 
//            ///     enn før for at de bedre skal beskrive det aktuelle klimaet.
//
//            ///
//            /// Datoer for normalperioden
//            ///
//            let startDate: String = "1991-01-01"
//            let endDate: String = "2020-12-31"
//            ///
//            /// Finner urlPart1 fra Settings()
//            ///
//            let urlPart1 = UserDefaults.standard.object(forKey: "Url1OpenMeteo") as? String ?? ""
//            logger.notice("\(urlPart1)")
//            if urlPart1 == "" {
//                Task.init {
//                    title = "Update setting for OpenMeteo 1."
//                    showAlert.toggle()
//                }
//            }
//            ///
//            /// Finner urlPart2 fra Settings()
//            ///
//            let urlPart2 = UserDefaults.standard.object(forKey: "Url2OpenMeteo") as? String ?? ""
//            logger.notice("\(urlPart2)")
//            if urlPart2 == "" {
//                Task.init {
//                    title = "Update setting for OpenMeteo 2."
//                    showAlert.toggle()
//                }
//            }
//            ///
//            /// Feilmelding dersom urlPart1 og / eller urlPart2 ikke har verdi
//            ///
//            if urlPart1.count > 0, urlPart2.count > 0 {
//                Task.init {
//                    logger.notice("lat = \(weatherInfo.latitude!)")
//                    logger.notice("lon = \(weatherInfo.longitude!)")
//                    
//                    (errorMessage, averageMonthlyDataRecord) = await GetAverageMonthlyWeather(urlPart1: urlPart1,
//                                                                                              urlPart2: urlPart2,
//                                                                                              startDate: startDate,
//                                                                                              endDate: endDate,
//                                                                                              lat: weatherInfo.latitude ?? 0.00,
//                                                                                              lon: weatherInfo.longitude ?? 0.00)
//                    logger.notice("averageMonthPrecification.count = \(averageMonthPrecification.count)")
//                    for i in 0...11 {
//                        logger.notice("WeatherForecast = \(averageMonthPrecification[i])")
//                    }
//                    ///
//                    /// stringKey kommer fra extension LocalizedStringKey i Extensions.swift
//                    ///
//                    if errorMessage.stringKey!.count > 0 {
//                        title = "AverageData"
//                        message = errorMessage
//                        showAlert.toggle()
//                    }
//                }
//            }
//        }
        if persist == true {
            ///
            /// Finner hourForecast:
            ///
            let date = Date().adding(seconds: weatherInfo.offsetSec)
            let start = date.setTime(hour: 0, min: 0, sec: 0)
            let startDate = start?.adding(days: -1)
            let endDate = (Calendar.current.date(byAdding: .day, value: 11, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
            
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
                debugPrint(error)
                title = "Error finding 'hourForecast'."
                message = ServerResponse(error: error.localizedDescription)
                showAlert.toggle()
            }
            ///
            /// Sjekker om hourForecast ikke er tom:
            ///
            if hourForecast?.isEmpty == true {
                persist = false
                title = "Find the hourForecast data"
                message = "The hourForecast is empty."
                showAlert.toggle()
            }
            ///
            /// Går bare videre dersom persist er true:
            ///
            if persist == true {
                ///
                /// Finner soloppgang og solnedgang:
                ///
                let url = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
                let value : (String, [String], [String], Int, Int) =
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
                /// Oppdatere lengden av dagen
                ///
                currentWeather.dayLength = value.3
                currentWeather.dayIncrease = value.4
                ///
                /// Finner data for månen:
                ///
                let url1 = UserDefaults.standard.object(forKey: "UrlWeatherApiMoon") as? String ?? ""
                let key = UserDefaults.standard.object(forKey: "KeyWeatherApi") as? String ?? ""
                let (error, moonRec) =
                await FindMoonUpDown(url: url1,
                                     key: key,
                                     latitude: weatherInfo.latitude,
                                     longitude: weatherInfo.longitude)
                if error != "" {
                    moonRecord = MoonRecord()
                } else {
                    moonRecord = moonRec
                }
                ///
                /// Gir melding og avslutter appen dersom sola data er tom :
                ///
                if sunRises.isEmpty == true || sunSets.isEmpty == true {
                    persist = false
                    title = "Find data for the the Sun or the Moon"
                    message = "The Sun or Moon data are empty."
                    showAlert.toggle()
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
                    
                    if status.count > 0 {
                        persist = false
                        title = "Find data for the Air Quality"
                        message = "The Air Quality data is empty."
                        showAlert.toggle()
                    }
                    
                    if persist == true {
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
                                currentWeather.moonPhase = moonRecord.moonPhase
                                /// moonrise
                                currentWeather.moonrise = moonRecord.moonrise
                                /// moonset
                                currentWeather.moonset = moonRecord.moonset
                                /// moonIllumination
                                currentWeather.moonIllumination = moonRecord.moonIllumination
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
                            debugPrint(error)
                            title = "Error finding 'weather'"
                            message = ServerResponse(error: error.localizedDescription)
                            showAlert.toggle()
                            ///
                            /// Lukker denne meldingen etter 10 sekunder:
                            ///
                            DismissAlertAndExitApp(seconds: 10, alert: &showAlert)
                            
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
            if persist == true {
                ///
                /// Finner snøfallet i perioden ut fra weather.dailyForecast
                ///
                ///
                /// Finner hourForecast
                ///
                dailyForecast = nil
                
                let location = CLLocation(latitude: weatherInfo.latitude ?? 0.00, longitude: weatherInfo.longitude ?? 0.00)
                
                let date = Date().adding(seconds: weatherInfo.offsetSec)
                let startDate = date.setTime(hour: 0, min: 0, sec: 0)
                let endDate = (Calendar.current.date(byAdding: .day, value: 10, to: startDate ?? Date())!).setTime(hour: 0, min: 0, sec: 0)
                do {
                    dailyForecast = try await WeatherService.shared.weather(for: location,
                                                                            including: .daily(startDate: startDate!,
                                                                                              endDate: endDate!))
                } catch {
                    debugPrint(error)
                    title = "Error finding 'dailyForecast'"
                    message = ServerResponse(error: error.localizedDescription)
                    showAlert.toggle()
                }
                ///
                /// Sjekker om hourForecast inneholder noen verdier > 0,00
                ///
                if dailyForecast != nil {
                    someSnow = false
                    dailyForecast!.forEach  {
                        if $0.date >= startDate! &&
                            $0.date <= endDate! {
                            if $0.snowfallAmount.value > 0.00 {
                                someSnow = true
                            }
                        }
                    }
                } else {
                    weatherInfo.offsetString = ""
                    persist = false
                    title = "Find the dailyForecast data"
                    message = "The dailyForecast is empty."
                    showAlert.toggle()
                } 
            }
        }
    }
}
