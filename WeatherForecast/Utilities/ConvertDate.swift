//
//  ConvertDate.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 18/04/2024.
//

import SwiftUI

func ConvertDate(date: String) -> String {
    var convertDate: String = ""
    var month1: String = ""
    ///
    /// Finn dagen
    ///
    let day = Int(date.suffix(2)) ?? 0
    ///
    /// Finn året
    ///
    let yearRange = date.startIndex..<date.index(date.startIndex, offsetBy: 4)
    let year = date[yearRange]
    ///
    /// Finn måneden
    ///
    let startIndex = date.index(date.startIndex, offsetBy: 5)
    let endIndex = date.index(date.startIndex, offsetBy: 7)
    let month = date[startIndex..<endIndex]
    ///
    /// Konverter måneden
    ///
    if month == "01" {
        month1 = String(localized: "jan")
    } else if month == "02" {
        month1 = String(localized: "feb")
    } else if month == "03" {
        month1 = String(localized: "mar")
    } else if month == "04" {
        month1 = String(localized: "apr")
    } else if month == "05" {
        month1 = String(localized: "may")
    } else if month == "06" {
        month1 = String(localized: "jun")
    } else if month == "07" {
        month1 = String(localized: "jul")
    } else if month == "08" {
        month1 = String(localized: "aug")
    } else if month == "09" {
        month1 = String(localized: "sep")
    } else if month == "10" {
        month1 = String(localized: "oct")
    } else if month == "11" {
        month1 = String(localized: "nov")
    } else if month == "12" {
        month1 = String(localized: "Dec")
    }

    if UIDevice.isIpad {
        convertDate = "\(day)" + ". " + month1 + " " + year
    } else {
        convertDate = "\(day)" + ". " + month1
    }
    
    return convertDate
}

