//
//  CountriesView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/01/2024.
//

import SwiftUI
import Foundation


///
/// https://blog.stackademic.com/search-data-in-swiftui-list-view-c62e990b3a32
///

struct CountriesView: View {
    
    
    ///     import OSLog
    ///     let value = 12345
    ///     let logger = Logger(subsystem: "com.janhovland.WeatherForecast", category: "WeatherForecastMain")
    //
    

    @State private var countries: [CountryRecord] = []
    @State private var searchText = ""
    @State private var message: LocalizedStringKey = ""
    @State private var title: LocalizedStringKey = ""
    @State private var showAlert: Bool = false
    
    @State private var arrayDataRecord = ArrayDataRecord(time: [""], temperature: [0.00])
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { item in
                    LazyHStack (alignment: .top, spacing: UIDevice.isIpad ? 100 : 10) {
                        VStack (alignment: .leading) {
                            Text("Country: ")
                            Text("Land code: ")
                            Text("Flag: ")
                            Text("Capitol: ")
                            Text("Population: ")
                        }
                        .foregroundStyle(.green)
                        VStack (alignment: .leading) {
                            Text(item.name)
                                .foregroundStyle(.green)
                                .modifier(CountryName(name: item.name, length: 35))
                            Text(item.code)
                            Text(item.flag)
                            if item.capital == "Unknown" {
                                let capital = String(localized: "Unknown")
                                Text(capital)
                                    .foregroundStyle(.red)
                            } else {
                                Text(item.capital)
                            }
                            Text("\(item.population)")
                        }
                    }
                    .font(.subheadline)
                    .padding(2)
                }
            }
            .searchable(text: $searchText)
            .listStyle(.inset)
            .scrollIndicators(.hidden)
        }
        .padding(.leading, 10)
        .navigationBarTitle("Countries overview")
        .navigationBarTitleDisplayMode(.inline)
        .alert(title, isPresented: $showAlert) {
            }
            message: {
                Text(message)
        }
        .task {
            
            Task.init {
                ///
                /// Dokumentasjon: https://open-meteo.com/en/docs/
                ///
                logger.notice("Start")

                let urlSession = URLSession.shared
                ///
                /// Normalen er temp over 30 år 1994-01-01 til og med 2023-12-31 = 10957 dager
                ///
                
                ///
                /// Husk å sette timezone=auto for å riktig tidssone
                ///
                let urlString = "https://archive-api.open-meteo.com/v1/archive?latitude=52.52&longitude=13.41&timezone=auto&start_date=1994-01-01&end_date=2023-12-31&daily=temperature_2m_mean"

                let url = URL(string: urlString)
                let (jsonData, _) = try await urlSession.data(from: url!)
                let data = try? JSONDecoder().decode(ArrayData.self, from: jsonData)
                
                logger.notice("Stop fetching")
                
                arrayDataRecord.time = (data?.daily.time)!
                arrayDataRecord.temperature = (data?.daily.temperature2MMean)!
                
                logger.notice("Average temp = \(FindAverageArray(array: arrayDataRecord.temperature))")
                logger.notice("Number og elements = \(arrayDataRecord.temperature.count)")
                
            }
           
            
            /// Beskrivelse av feltene for:
            /// https://restcountries.com/v3.1/all?fields=
            ///
            /// https://gitlab.com/restcountries/restcountries/-/blob/master/FIELDS.md
            ///
            
            let url1 = UserDefaults.standard.object(forKey: "UrlRestCountries") as? String ?? ""
            if url1 == "" {
                Task.init {
                    title = "Update setting for RestCountries."
                    showAlert.toggle()
                }
            } else {
                var value1: (String, [CountryRecord])
                await value1 = FindCountries(urlString: url1)
                if value1.0 == "" {
                    countries = value1.1
                } else {
                    countries.removeAll()
                }
            }
        }
        ///
        /// Sort list using search text
        ///
        var searchResults: [CountryRecord] {
            if searchText.isEmpty {
                return countries
            } else {
                return countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
    }
}
