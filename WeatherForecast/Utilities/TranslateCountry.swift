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
        
    case "Cambodia":                        nation = String(localized: "Cambodia")
    case "Cameroon":                        nation = String(localized: "Cameroon")
    case "Canada":                          nation = String(localized: "Canada")
    case "Cape Verde":                      nation = String(localized: "Cape Verde")
    case "Caribbean Netherlands":           nation = String(localized: "Caribbean Netherlands")
    case "Cayman Island":                   nation = String(localized: "Cayman Island")
    case "Central African Republic":        nation = String(localized: "Central African Republic")
    case "Chad":                            nation = String(localized: "Chad")
    case "China":                           nation = String(localized: "China")
    case "Christmas Island":                nation = String(localized: "Christmas Island")
    case "Cocos (Keeling) Islands":         nation = String(localized: "Cocos (Keeling) Islands")
    case "Comoros":                         nation = String(localized: "Comoros")
    case "Cook Islands":                    nation = String(localized: "Cook Islands")
    case "Croatia":                         nation = String(localized: "Croatia")
    case "Cyprus":                          nation = String(localized: "Cyprus")
    case "Czechia":                         nation = String(localized: "Czechia")
    case "DR Congo":                        nation = String(localized: "DR Congo")
    case "Denmark":                         nation = String(localized: "Denmark")
    case "Deutschland":                     nation = String(localized: "Deutschland")
    case "Dominican Republic":              nation = String(localized: "Dominican Republic")
    case "Equatorial Guinea":               nation = String(localized: "Equatorial Guinea")
    case "Estonia":                               nation = String(localized: "Estonia")
    case "Ethiopia":                              nation = String(localized: "Ethiopia")
    case "Falkland Islands":                      nation = String(localized: "Falkland Islands")
    case "Faroe Islands":                         nation = String(localized: "Faroe Islands")
    case "France":                                nation = String(localized: "France")
    case "French Guiana":                         nation = String(localized: "French Guiana")
    case "French Polynesia":                      nation = String(localized: "French Polynesia")
    case "French Southern and Antarctic Lands":   nation = String(localized: "French Southern and Antarctic Lands")
        
        
//    case "": nation = String(localized: "")
        
    case "Norway":                          nation = String(localized: "Norway")
        
    case "Russia":                          nation = String(localized: "Russia")
        
    case "Spain":                           nation = String(localized: "Spain")
        
    case "Turkey":                          nation = String(localized: "Turkey")
        
    case "United Kingdom":                  nation = String(localized: "United Kingdom")
    case "United States":                   nation = String(localized: "United States")
        
    default:                                nation = country
    }
    return nation
}
