//
//  FindCountries.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/01/2024.
//

import Foundation
import SwiftUI

func FindCountries(urlString: String?)  async -> (String, [CountryRecord]) {
    
    var errors : String = ""
    var countryRecord =  CountryRecord(id: UUID(), name: "", code: "", flag: "")
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
            countryData?.forEach { data in
                countryRecord.id = UUID()
                countryRecord.name = TranslateCountry(country: data.name.common)
                countryRecord.code = data.cca2
                countryRecord.flag = data.flag
                
                if data.capital.isEmpty {
                    countryRecord.capital = "Unknown"
                } else {
                   let capital = data.capital[0]
                   countryRecord.capital = capital
                }
                countryRecord.population = data.population
                countryRecords.append(countryRecord)
                countryRecords.sort(by: {$0.name < $1.name})
            }
         } catch {
            errors = "\(error)"
        }
    }
    return (errors, countryRecords)
}
