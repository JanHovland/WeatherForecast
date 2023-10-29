//
//  TranslateCountry.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 17/03/2023.
//

import Foundation

func TranslateCountry(country: String) -> String {
    var nation: String = ""
    switch country {
    case "Norway":          nation = String(localized: "Norway")
    case "United States":   nation = String(localized: "United States")
    case "United Kingdom":  nation = String(localized: "United Kingdom")
    case "China":           nation = String(localized: "China")
    case "Turkey":          nation = String(localized: "Turkey")
    case "Canada":          nation = String(localized: "Canada")
    case "Russia":          nation = String(localized: "Russia")
    case "France":          nation = String(localized: "France")
    default:                nation = country
    }
    return nation
}
