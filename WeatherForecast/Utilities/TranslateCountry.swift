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
    case "Afghanistan":                     nation = String(localized: "Afghanistan")
    case "Algeria":                         nation = String(localized: "Algeria")
    case "American Samoa":                  nation = String(localized: "American Samoa")
    case "Antarctica":                      nation = String(localized: "Antarctica")
    case "Antigua and Barbuda":             nation = String(localized: "Antigua and Barbuda")
    case "Austria":                         nation = String(localized: "Austria")
    case "Azerbaijan":                      nation = String(localized: "Azerbaijan")
        
    case "Belarus":                         nation = String(localized: "Belarus")
    case "Belgium":                         nation = String(localized: "Belgium")
    case "Bosnia and Herzegovina":          nation = String(localized: "Bosnia and Herzegovina")
    case "Bouvet Island":                   nation = String(localized: "Bouvet Island")
    case "Brazil":                          nation = String(localized: "Brazil")
    case "British Indian Ocean Territory":  nation = String(localized: "British Indian Ocean Territory")
    case "British Virgin Islands":          nation = String(localized: "British Virgin Islands")
        
//    case "":              nation = String(localized: " ")

    case "China":                   nation = String(localized: "China")
    case "Canada":                  nation = String(localized: "Canada")

    case "Deutschland":             nation = String(localized: "Deutschland")
        
    case "France":                  nation = String(localized: "France")
        
    case "Norway":                  nation = String(localized: "Norway")
        
    case "Russia":                  nation = String(localized: "Russia")
        
    case "Spain":                   nation = String(localized: "Spain")
        
    case "Turkey":                  nation = String(localized: "Turkey")
        
    case "United Kingdom":          nation = String(localized: "United Kingdom")
    case "United States":           nation = String(localized: "United States")

    default:                        nation = country
    }
    return nation
}
