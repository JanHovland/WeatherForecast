//
//  WeatherForecastSearchPlace.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 23/10/2023.
//

import SwiftUI
import CloudKit

//// https://stackoverflow.com/questions/72690545/navigationview-back-button-not-showing
///
/// Back button vises på iPhone.
///   Kommer rundt problemet på iPad ved å velge et nytt punkt fra sidemenyen.
///

struct WeatherForecastSearchPlace: View {
    
    @State private var opacityIndicator: Double = 0.00
    @State private var searchText: String = ""
    @State private var geoRecords = [GeoRecord]()
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    @State private var places = [Place]()
    @State private var sheetLocal: Bool = false
    @State private var sheetPlace: Bool = false
    @State private var indexSetDelete = IndexSet()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ActivityIndicator(opacity: $opacityIndicator)
                .offset(y: UIDevice.isIpad ? -375 : -325)
            SearchBar(searchText: $searchText)
                .offset(y: UIDevice.isIpad ? -15 : 0)
            ///
            /// Legger inn det første tegnet i søkefeltet:
            ///
                .onChange(of: searchText) { oldText, text in
                    if searchText.count > 0 {
                        
                    } else {
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
            List {
                ForEach(geoRecords) { record in
                    NavigationLink(destination: SaveNewPlace(geoRecord: record,
                                                             searchText: searchText)) {
                        VStack {
                            HStack {
                                Text(record.flag)
                                Text(record.country)
                                Text(record.formatted)
                            }
                        }}
                }
            }
            
        }
        .offset(y: -20)
        .navigationTitle("Search ...")
        .navigationBarTitleDisplayMode(.inline)
        .overlay (
            VStack (spacing: 0) {
                HStack {
                    Spacer()
                    if geoRecords.count > 0 {
                        Text(String(localized: "Choose a new place to save."))
                    } else {
                        Text("")
                    }
                    Spacer()
                }
                .offset(y: UIDevice.isIpad ? -295 : -290)
            }
        )
    }
}

struct SaveNewPlace: View {
    var geoRecord: GeoRecord
    var searchText: String
    
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    @State private var showAlertFile: Bool = false

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text(geoRecord.flag)
            Text(geoRecord.country)
            Text(geoRecord.formatted)
        }
        .navigationTitle("Selected place")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("", systemImage: "line.3.horizontal") {
                    ///
                    /// Lagre det lokale stedet
                    ///
                    Button (action: {
                        Task.init {
                            title = "Save this place"
                            showAlertFile.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("Save this place")
                            Image(systemName: "square.and.arrow.up")
                                .symbolRenderingMode(.multicolor)
                        }
                    })
                    ///
                    /// Avbryt
                    ///
                    Button (action: {
                        Task.init {
                            title = "Cancel"
                            dismiss()
                        }
                    }, label: {
                        HStack {
                            Text("Cancel")
                            Image(systemName: "x.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(.systemGray3))
                                .padding(30)
                                .offset(x: 20)
                       }
                    })
                }
            }
        }
        ///
        ///  Viser meldingene:
        ///
        .alert(title, isPresented: $showAlert) {
        }
        message: {
            Text(message)
        }
        .alert(isPresented: $showAlertFile) {
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(Text("Cancel")) {
                    dismiss()
                },
                secondaryButton: .destructive(Text("Save")) {
                    ///
                    /// Lagre valgt sted
                    ///
                    Task.init {
                        let place = Place(place: searchText,
                                          flag: geoRecord.flag,
                                          country: geoRecord.country,
                                          lon: geoRecord.longitude,
                                          lat: geoRecord.latitude,
                                          offsetSec: geoRecord.offsetSec,
                                          offsetString: geoRecord.offsetString,
                                          dst: geoRecord.dst,
                                          zoneName: geoRecord.zoneName,
                                          zoneShortName: geoRecord.zoneShortName)
                        
                        let value: (Bool, LocalizedStringKey)
                        value = await SaveNewPlace(place)
                        if value.0 == true {
                            ///
                            /// Stedet er lagret
                            ///
                            title = "Save place"
                            message = "\nIt can take some time until the place is saved on CloudKit.\nSelect \"Refresh my places\""
                            showAlert.toggle()
                        } else {
                            ///
                            /// Stedet ble ikke lagret:
                            ///
                            title = "Save place"
                            message = value.1
                            showAlert.toggle()
                        }
                    }
                }
            )
        }
    }
    
}
