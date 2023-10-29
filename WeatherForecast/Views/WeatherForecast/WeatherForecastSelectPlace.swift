//
//  WeatherForecastSelectPlace.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 17/01/2023.
//

import SwiftUI
import CloudKit
import WeatherKit


struct WeatherForecastSelectPlace: View {
    
    @StateObject var locationService = LocationService()
    
    @State private var searchText: String = ""
    @State private var place = Place(place: "", lon: nil, lat: nil)
    @State private var places = [Place]()
    @State private var indexSetDelete = IndexSet()
    @State private var recordID: CKRecord.ID?
    @State private var place1: String = ""
    @State private var lat: Double?
    @State private var lon: Double?
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    @State private var geoRecord = GeoRecord()
    @State private var geoRecords = [GeoRecord]()
    @State private var opacityPlaces: Double = 1.00
    @State private var opacityGeoRecords: Double = 0.00
    @State private var opacityIndicator: Double = 1.00
    @State private var sheetLocal: Bool = false
    @State private var sheetPlace: Bool = false
    @State private var heading: String = String(localized: "Weather")
    
    @Environment(WeatherInfo.self) private var weatherInfo
    ///
    /// https://medium.com/geekculture/search-using-mapkit-in-swiftui-636426836ab
    ///
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(heading)
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                        .renderingMode(.original)
                        .font(.system(size: 30, weight: .light))
                        .contextMenu {
                            ///
                            /// Frisk opp:
                            ///
                            Button (action: {
                                Task.init {
                                    ///
                                    /// Markerer starten :
                                    ///
                                    /// Sjekker  userSetting "ShowWeather"
                                    ///
                                    let showWeatherStatus = UserDefaults.standard.object(forKey: "ShowWeather") as? Bool ?? false
                                    if showWeatherStatus == true {
                                        title = "Refresh all places"
                                        message = "Refresh for all places has started.\n\nPlease note that this alert will only show for a few seconds."
                                        showAlert.toggle()
                                        dismissAlert(seconds: 10)
                                    }
                                    let value: (LocalizedStringKey, [Place])
                                    let showWeather = UserDefaults.standard.object(forKey: "ShowWeather") as? Bool ?? false
                                    value = await RefreshAllPlaces(refreshWeather: showWeather)
                                    if value.0 == "" {
                                        places = value.1
                                        title = "Refresh all places"
                                        message = "Refresh all places finished"
                                        showAlert.toggle()
                                    } else {
                                        title = "Refresh"
                                        message = value.0
                                        showAlert.toggle()
                                    }
                                    ///
                                    /// Finner currentLocation:
                                    ///
                                    let location = CLLocation(latitude: weatherInfo.localLatitude ?? 0.00,
                                                              longitude: weatherInfo.localLongitude ?? 0.00)
                                    let weather : Weather?
                                    do {
                                        weather = try await WeatherService.shared.weather(for: location)
                                        if let weather {
                                            weatherInfo.localTemperature = weather.currentWeather.temperature.value
                                            weatherInfo.localLowTemperature = weather.dailyForecast.forecast[0].lowTemperature.value
                                            weatherInfo.localHighTemperature =  weather.dailyForecast.forecast[0].highTemperature.value
                                            weatherInfo.localCondition = weather.currentWeather.condition.description
                                            weatherInfo.localIsDaylight = weather.currentWeather.isDaylight
                                            weatherInfo.localDate = Date() // .adding(seconds: places[i].offsetSec)
                                        }
                                    } catch {
                                        message = LocalizedStringKey(error.localizedDescription)
                                        debugPrint(error)
                                    }
                                }
                            }, label: {
                                HStack {
                                    Text("Refresh all places")
                                    Image(systemName: "arrow.uturn.right.circle")
                                }
                            })
                            ///
                            /// Frisk opp offsetSec og offsetString for de stedene som ligger i CloudKit::
                            ///
                            Button (action: {
                                Task.init {
                                    ///
                                    /// Markerer starten :
                                    ///
                                    title = "Refresh offset for places"
                                    message = "Reset offset for the places has started.\n\nPlease note that this alert will only show for a few seconds."
                                    showAlert.toggle()
                                    dismissAlert(seconds: 10)
                                    ///
                                    /// Begynner på modifiseringen:
                                    ///
                                    let value: (Bool, LocalizedStringKey)
                                    value = await RefreshOffset()
                                    if value.0 == false {
                                        title = "Refresh offset for places"
                                        message = value.1
                                        showAlert.toggle()
                                    } else {
                                        ///
                                        /// Markerer slutten:
                                        ///
                                        title = "Refresh offset for places"
                                        message = value.1
                                        showAlert.toggle()
                                    }
                                }
                            }, label: {
                                HStack {
                                    Text("Refresh offset")
                                    Image(systemName: "arrow.uturn.right.circle")
                                }
                            })
                            
                        }
                }
                .padding(.horizontal, 30)
            }
            ActivityIndicator(opacity: $opacityIndicator)
                .offset(y: UIDevice.isIpad ? -375 : -325)
            SearchBar(searchText: $searchText)
                .offset(y: UIDevice.isIpad ? -15 : -15)
                ///
                /// Legger inn det første tegnet i søkefeltet:
                ///
                .onChange(of: searchText) { oldText, text in
                    if searchText.count > 0 {
                        opacityGeoRecords = 1.00
                        opacityPlaces = 0.00
                    } else {
                        opacityGeoRecords = 0.00
                        opacityPlaces = 1.00
                        geoRecords.removeAll()
                        ///
                        /// Fjerner tastaturet:
                        ///
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                ///
                /// Trykker 'retur' (iPhone) eller '􁂆' (iPad):
                ///
                .onSubmit {
                    Task.init {
                        ///
                        ///  Må finne longitude og latiude for dette stedet:
                        ///
                        let key = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
                        let urlOpenCage = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
                        ///
                        /// Finn georecords :
                        ///
                        geoRecords = await GetForwardGeoCode(place: searchText,
                                                             key: key,
                                                             urlOpenCage: urlOpenCage)
                        ///
                        /// Dersom det ikke finnes noen geoRecords kommer det en feilmelding:
                        ///
                        if geoRecords.count == 0 {
                            title = "Find places"
                            message = "The search for '\(searchText)' did not find any record."
                            showAlert.toggle()
                        }
                    }
                }
            ///
            /// Lister ut de potensielle stedene:
            ///
            List {
                ForEach(geoRecords) { record in
                    VStack {
                        HStack {
                            Text(record.flag)
                            Text(record.country)
                            Text(record.formatted)
                        }
                        .onTapGesture {
                            places.removeAll()
                            ///
                            ///  Lagre dette stedet:
                            ///
                            Task.init {
                                var lon: Double = 0.00
                                var lat: Double = 0.00
                                var offsetString: String = ""
                                if record.longitude != nil {
                                    lon = record.longitude!
                                }
                                if record.latitude != nil {
                                    lat = record.latitude!
                                }
                                weatherInfo.offsetSec = record.offsetSec
                                offsetString = record.offsetString
                                weatherInfo.dst = record.dst
                                weatherInfo.zoneName = record.zoneName
                                weatherInfo.zoneShortName = record.zoneShortName
                                
                                let place = Place(place: searchText,
                                                  flag: record.flag,
                                                  country: record.country,
                                                  lon: lon,
                                                  lat: lat,
                                                  offsetSec: weatherInfo.offsetSec,
                                                  offsetString: offsetString,
                                                  dst: weatherInfo.dst,
                                                  zoneName: weatherInfo.zoneName,
                                                  zoneShortName: weatherInfo.zoneShortName)
                                let value: (Bool, LocalizedStringKey)
                                value = await SaveNewPlace(place)
                                if value.0 == true {
                                    searchText = ""
                                    opacityPlaces = 1.00
                                    ///
                                    /// Stedet er lagret
                                    ///
                                    places.append(place)
                                    places.sort(by: {$0.place < $1.place})
                                    title = "Save place"
                                    message = value.1
                                    showAlert.toggle()
                                } else {
                                    ///
                                    /// Stedet ble ikke lagret:
                                    ///
                                    title = "Save place"
                                    message = value.1
                                    showAlert.toggle()
                                }
                                let value1: (LocalizedStringKey, [Place])
                                let showWeather = UserDefaults.standard.object(forKey: "ShowWeather") as? Bool ?? false
                                value1 = await RefreshAllPlaces(refreshWeather: showWeather)
                                if value1.0 != "" {
                                    title = "Refresh"
                                    message = value1.0
                                    showAlert.toggle()
                                } else {
                                    places = value1.1
                                }
                            }
                        }
                    }
                    /// opacityGeoRecords = 0.00 skjuler VStack
                    /// opacityGeoRecords = 1.00 vise VStack
                    ///
                    .opacity(opacityGeoRecords)
                }
                ///
                ///  Viser alle stedene:
                ///
                if opacityPlaces == 1.00 {
                    ///
                    /// Viser local posisjon med tilhørende data:
                    ///
                    VStack {
                        ///
                        /// Viser locale data:
                        ///
                        Image("Cloud")
                            .resizable()
                            .frame(height: UIDevice.isIpad ? 90 : 90)
                            .clipped()
                            .cornerRadius(20)
                            .opacity(weatherInfo.localIsDaylight == true ? 0.40 : 0.25)
                            .overlay (
                                VStack (spacing: 0) {
                                    HStack {
                                        Text(String(localized: "My position"))
                                            .font(UIDevice.isIpad ? .title : .title3)
                                        Spacer()
                                    }
                                    VStack {
                                        HStack (spacing: UIDevice.isIpad ? 40 : 20) {
                                            Text(weatherInfo.localPlaceName)
                                                .font(UIDevice.isIpad ? .title2 : .body)
                                            Text(weatherInfo.localFlag)
                                                .font(.title2)
                                            let country = TranslateCountry(country: weatherInfo.localCountry)
                                            Text(country)
                                                .font(UIDevice.isIpad ? .title2 : .body)
                                            Spacer()
                                            Text("\(Int(weatherInfo.localTemperature.rounded()))º")
                                                .font(UIDevice.isIpad ? .title2 : .title3)
                                        }
                                        HStack (spacing: 20) {
                                            Text("\(FormatDateToString(date: weatherInfo.localDate, format: ("HH:mm"), offsetSec: weatherInfo.offsetSec))")
                                                .font(UIDevice.isIpad ? .title2 : .body)
                                            Text(weatherInfo.localCondition)
                                                .font(UIDevice.isIpad ? .body : .footnote)
                                            Spacer()
                                            Text(String("H: \(Int(round(weatherInfo.localHighTemperature))) º L: \(Int(round(weatherInfo.localLowTemperature))) º"))
                                                .font(UIDevice.isIpad ? .title2 : .body)
                                        }
                                    }
                                    .padding(.bottom, UIDevice.isIpad ? 5 : 5)
                                }
                                .fontWeight(.light)
                                .padding(.horizontal, UIDevice.isIpad ? 50 : 20)
                            )
                    }
                    .onTapGesture {
                        sheetLocal.toggle()
                    }
                    .fullScreenCover(isPresented: $sheetLocal, content:   {
                        WeatherForecast(expOption: .intern,
                                        extPlaceName: weatherInfo.localPlaceName,
                                        extLatitude: weatherInfo.localLatitude ?? 0.00,
                                        extLongitude: weatherInfo.localLongitude ?? 0.00,
                                        extOffsetString: weatherInfo.localOffsetString,
                                        extOffsetSec: weatherInfo.localOffsetSec)
                        .padding(.top, 60)
                        .padding(.leading, 321)
                        .clearModalBackground()
                    })
                    ForEach(places) { place in
                        VStack {
                            ///
                            /// Viser alle stedene:
                            ///
                            WeatherForecastSelectCardView(place: place)
                        }
                        .offset(y: -15)
                        .onTapGesture {
                            ///
                            /// Tar vare på variablene til valgt sted:
                            ///
                            weatherInfo.placeName = place.place
                            weatherInfo.countryName = TranslateCountry(country: place.country)
                            weatherInfo.placeLatitude = place.lat ?? 0.00
                            weatherInfo.placeLongitude = place.lon ?? 0.00
                            weatherInfo.placeOffsetString = place.offsetString
                            weatherInfo.placeOffsetSec = place.offsetSec
                            sheetPlace.toggle()
                        }
                    }
                    ///
                    /// Sletter et sted i listen:
                    ///
                    .onDelete(perform: { indexSet in
                        indexSetDelete = indexSet
                        let place: Place = Place(place : places[indexSet.first!].place,
                                                 lon: places[indexSet.first!].lon,
                                                 lat: places[indexSet.first!].lat)
                        Task.init {
                            var value: (Bool, LocalizedStringKey)
                            value = await DeleteOnePlace(place)
                            if value.0 == true {
                                title = "Delete a place"
                                message = value.1
                                showAlert.toggle()
                            } else {
                                title = "Delete a place"
                                message = value.1
                                showAlert.toggle()
                            }
                            ///
                            /// Viser resten av personene
                            ///
                            places.removeAll()
                            let value1: (LocalizedStringKey, [Place])
                            
                            let showWeather = UserDefaults.standard.object(forKey: "ShowWeather") as? Bool ?? false
                            value1 = await RefreshAllPlaces(refreshWeather: showWeather)
                            if value1.0 != "" {
                                title = "Refresh"
                                message = value1.0
                                showAlert.toggle()
                            } else {
                                places = value1.1
                            }
                        }
                    })
                    .font(.headline)
                }
            }
            ///
            /// .fullScreenCover er en modifier som viser aktuelt sheet på hele skjermen:
            ///
            .fullScreenCover(isPresented: $sheetPlace, content:  {
                ///
                /// Viser valgt sted:
                ///
                WeatherForecast(expOption: .selection,
                                extPlaceName: weatherInfo.placeName,
                                extCountryName: TranslateCountry(country: weatherInfo.countryName),
                                extLatitude: weatherInfo.placeLatitude ?? 0.00 ,
                                extLongitude: weatherInfo.placeLongitude ?? 0.00 ,
                                extOffsetString: weatherInfo.placeOffsetString,
                                extOffsetSec: weatherInfo.placeOffsetSec)
                .padding(.top, 60)
                .padding(.leading, 321)
                .clearModalBackground()

            })
            ///
            /// https://blog.techchee.com/handy-withnavigationview-custom-modifier-for-swiftui/
            ///
            ///  For å være den samme i både iPhone og iPad måtte det lages en viewModifier:
            ///  WeatherForecastViewModifier(withNavigationView: UIDevice.isIpad ? false : true)) :
            ///
            ///  if (withNavigationView) {
            ///    NavigationView {
            ///      content
            ///    }
            ///    .navigationViewStyle(.stack)
            ///  }  else {
            ///     content
            ///  }
            ///
            .modifier(WeatherForecastViewModifier(withNavigationView: UIDevice.isIpad ? false : true))
            .listStyle(InsetListStyle())
            ///
            ///  Viser meldingene:
            ///
            .alert(title, isPresented: $showAlert) {
            }
            message: {
                Text(message)
            }
        }
        .onAppear {
            Task.init {
                ///
                /// Frisker opp visning av de stedene som ligger i ClouKit:
                ///
                let value: (LocalizedStringKey, [Place])
                
                let showWeather = UserDefaults.standard.object(forKey: "ShowWeather") as? Bool ?? false
                value = await RefreshAllPlaces(refreshWeather: showWeather)
                if value.0 != "" {
                    title = "Refresh"
                    message = value.0
                    showAlert.toggle()
                } else {
                    places = value.1
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
