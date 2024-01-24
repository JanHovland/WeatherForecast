//
//  FindCountries.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/01/2024.
//

import Foundation

func FindCountries(urlString: String?)  async -> (String, [CountryRecord]) {
    
    var errors : String = ""
    var countryRecords : [CountryRecord] = []
    
    let url = URL(string: urlString ?? "")
    if let url {
        do {
            let urlSession = URLSession.shared
            let (jsonData, _) = try await urlSession.data(from: url)
            let countryData = try? JSONDecoder().decode(CountryInfo.self, from: jsonData)
            ///
            /// Oppdaterer countryRecord:
            ///
            countryData?.forEach { value in
                print(value.name.common)
            }
         } catch {
            errors = "\(error)"
        }
    }
    return (errors, countryRecords)
}
