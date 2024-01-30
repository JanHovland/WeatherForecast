//
//  CountriesView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 29/01/2024.
//

import SwiftUI

///
/// https://blog.stackademic.com/search-data-in-swiftui-list-view-c62e990b3a32
///

struct CountriesView: View {
    @State private var countries: [CountryRecord] = []
    @State private var searchText = ""
    
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
            .listStyle(.inset)
            .scrollIndicators(.hidden)
        }
        .padding(.top, -20)
        .padding(.leading, 10)
        .navigationBarTitle("Countries overview")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .task {
            /// Beskrivelse av feltene for:
            /// https://restcountries.com/v3.1/all?fields=
            ///
            /// https://gitlab.com/restcountries/restcountries/-/blob/master/FIELDS.md
            ///
            let url1 = "https://restcountries.com/v3.1/all?fields=name,cca2,flag,capital,population"
            var value1: (String, [CountryRecord])
            await value1 = FindCountries(urlString: url1)
            if value1.0 == "" {
                countries = value1.1
            } else {
                countries.removeAll()
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
