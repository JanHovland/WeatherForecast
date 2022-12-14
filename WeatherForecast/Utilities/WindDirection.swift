//
//  WindDirection.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/12/2022.
//

import Foundation

func WindDirection(degree: Double, option: EnumType) -> String {
    var direction : String = ""

    if option == .shortDirection {
        if degree < 11.25 || degree > 348.75 {
            direction = String(localized: "N")
        } else if degree < 22.50 {
            direction =  String(localized: "NNE")
        } else if degree < 67.5 {
            direction =  String(localized: "ENE")
        } else if degree < 90.0 {
            direction =  String(localized: "E")
        } else if degree < 112.5 {
            direction =  String(localized: "ESE")
        } else if degree < 135.00 {
            direction =  String(localized: "SE")
        } else if degree < 157.5 {
            direction =  String(localized: "SSE")
        } else if degree < 180.00 {
            direction =  String(localized: "S")
        } else if degree   < 202.50 {
            direction =  String(localized: "SSW")
        } else if degree   < 225.00 {
            direction =  String(localized: "SW")
        } else if degree  < 247.50 {
            direction =  String(localized: "WSW")
        } else if degree  < 270.00 {
            direction =  String(localized: "W")
        } else if degree  < 292.50 {
            direction =  String(localized: "WNW")
        } else if degree  < 315.00 {
            direction =  String(localized: "NW")
        } else {
            direction =  String(localized: "NNW")
        }
    } else if option == .longDirection {
        if degree  < 11.25 || degree  > 348.75 {
            direction = String(localized: "north")
        } else if degree  < 22.50 {
            direction =  String(localized: "north-northeast")
        } else if degree  < 67.5 {
            direction =  String(localized: "east-northeast")
        } else if degree  < 90.0 {
            direction =  String(localized: "east")
        } else if degree  < 112.5 {
            direction =  String(localized: "east-southeast")
        } else if degree  < 135.00 {
            direction =  String(localized: "southeast")
        } else if degree  < 157.5 {
            direction =  String(localized: "south-southeast")
        } else if degree  < 180.00 {
            direction =  String(localized: "south")
        } else if degree  < 202.50 {
            direction =  String(localized: "south-southwest")
        } else if degree  < 225.00 {
            direction =  String(localized: "southwest")
        } else if degree  < 247.50 {
            direction =  String(localized: "west-southwest")
        } else if degree  < 270.00 {
            direction =  String(localized: "west")
        } else if degree  < 292.50 {
            direction =  String(localized: "west-northwest")
        } else if degree  < 315.00 {
            direction =  String(localized: "northwest")
        } else {
            direction =  String(localized: "north-northwest")
        }    }

    return direction

}

/*
 
 
 Forkortelse    Beskrivelse     Min.        Middel      Maks.
 
 N              nord            348,75      0           11,25
 NN??            nord-nord??st    11,25       22,5        33,75
 ??N??            ??st-nord??st     56,25       67,5        78,75
 ??              ??st             78,75       90          101,25
 ??S??            ??st-s??r??st      101,25      112,5       123,75
 S??             s??r??st          123,75      135         146,25
 SS??            s??r-s??r??st      146,25      157,5       168,75
 S              s??r             168,75      180         191,25
 SSV            s??r-s??rvest     191,25      202,5       213,75
 SV             s??rvest         213,75      225         236,25
 VSV            vest-s??rvest    236,25      247,5       258,75
 V              vest            258,75      270         281,25
 VNV            vest-nordvest   281,25      292,5       303,75
 NV             nordvest        303,75      315         326,25
 NNV            nord-nordvest   326,25      337,5       348,75


 
 */
