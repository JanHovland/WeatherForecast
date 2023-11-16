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
    } else if moonPhase == String(localized: "Waxing gibbous") {
        if moonIllumination > 50 ,
           moonIllumination <= 61 {
            image = "Waxing gibbous 1"
        } else if moonIllumination > 61,
                  moonIllumination <= 71 {
            image = "Waxing gibbous 2"
        } else if moonIllumination > 71,
                  moonIllumination <= 82 {
            image = "Waxing gibbous 3"
        } else if moonIllumination > 82,
                  moonIllumination <= 90 {
            image = "Waxing gibbous 4"
        } else if moonIllumination > 90,
                  moonIllumination <= 95 {
            image = "Waxing gibbous 5"
        } else if moonIllumination > 95,
                  moonIllumination <= 98 {
            image = "Waxing gibbous 6"
        }
    } else if moonPhase == String(localized: "Full Moon") {
        if moonIllumination > 98 ,
           moonIllumination <= 100 {
            image = "Full Moon"
        }
    } else if moonPhase == String(localized: "Waning Gibbous") {
        if moonIllumination < 100 ,
           moonIllumination >= 98 {
            image = "Waning Gibbous 1"
        } else if moonIllumination < 98 ,
                  moonIllumination >= 95 {
            image = "Waning Gibbous 2"
        } else if moonIllumination < 95 ,
                  moonIllumination >= 90 {
            image = "Waning Gibbous 3"
        } else if moonIllumination < 90,
                  moonIllumination >= 83 {
            image = "Waning Gibbous 4"
        } else if moonIllumination < 83,
                  moonIllumination >= 76 {
            image = "Waning Gibbous 5"
        } else if moonIllumination < 76,
                  moonIllumination >= 67 {
            image = "Waning Gibbous 6"
        } else if moonIllumination < 67,
                  moonIllumination >= 57 {
            image = "Waning Gibbous 7"
        }
    } else if moonPhase == String(localized: "Last Quarter") {
        if moonIllumination < 57,
           moonIllumination >= 50 {
            image = "Last Quarter"
        }
    } else if moonPhase == String(localized: "Waning Crescent") {
        if moonIllumination < 50,
           moonIllumination >= 40{
            image = "Waning Crescent 1"
        } else if moonIllumination < 40,
                  moonIllumination >= 30 {
            image = "Waning Crescent 2"
        } else if moonIllumination < 30,
                  moonIllumination >= 22 {
            image = "Waning Crescent 3"
        } else if moonIllumination < 22,
                  moonIllumination >= 14 {
            image = "Waning Crescent 4"
        } else if moonIllumination < 14,
                  moonIllumination >= 8 {
            image = "Waning Crescent 5"
        } else if moonIllumination < 8,
                  moonIllumination >= 3 {
            image = "Waning Crescent 6"
        } else if moonIllumination < 3,
                  moonIllumination > 0 {
            image = "Waning Crescent 7"
        }
    }
    
    return image
}

