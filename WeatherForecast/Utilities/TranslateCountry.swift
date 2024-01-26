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
    case "Afghanistan":             nation = String(localized: "Afghanistan")
    case "Algeria":                 nation = String(localized: "Algeria")
    case "American Samoa":          nation = String(localized: "American Samoa")
    case "Antarctica":              nation = String(localized: "Antarctica")
    case "Antigua and Barbuda":     nation = String(localized: "Antigua and Barbuda")
    case "Austria":                 nation = String(localized: "Austria")
    case "Azerbaijan":              nation = String(localized: "Azerbaijan")

    case "Norway":                  nation = String(localized: "Norway")
    case "United States":           nation = String(localized: "United States")
    case "United Kingdom":          nation = String(localized: "United Kingdom")
    case "China":                   nation = String(localized: "China")
    case "Turkey":                  nation = String(localized: "Turkey")
    case "Canada":                  nation = String(localized: "Canada")
    case "Russia":                  nation = String(localized: "Russia")
    case "France":                  nation = String(localized: "France")
    case "Deutschland":             nation = String(localized: "Deutschland")
    case "Spain":                   nation = String(localized: "Spain")
    default:                        nation = country
    }
    return nation
}
