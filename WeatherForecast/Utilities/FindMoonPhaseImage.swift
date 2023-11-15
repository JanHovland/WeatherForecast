//
//  FindMoonPhaseImage.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/11/2023.
//

import Foundation
import SwiftUI

func FindMoonPhaseImage(moonPhase: String,
                        moonIllumination: Int) -> String {
    
    var image: String = ""
    
    if moonPhase == String(localized: "Waxing Crescent") {
        if moonIllumination > 0 ,
           moonIllumination < 1 {
            image = "New Moon"
        } else if moonIllumination >= 1,
                  moonIllumination < 5 {
            image = "Waxing Crescent 1"
        } else if moonIllumination >= 5,
                  moonIllumination <  11 {
            image = "Waxing Crescent 2"
        } else if moonIllumination >= 11,
                  moonIllumination < 19 {
            image = "Waxing Crescent 3"
        } else if moonIllumination >= 19,
                  moonIllumination < 28 {
            image = "Waxing Crescent 4"
        } else if moonIllumination >= 28,
                  moonIllumination < 38 {
            image = "Waxing Crescent 5"
        }
    } else if moonPhase == String(localized: "First Quarter") {
        if moonIllumination > 38 ,
           moonIllumination <= 50 {
            image = "First Quarter"
        }
    }
    
    return image
}

