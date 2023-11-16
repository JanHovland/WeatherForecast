//
//  FindMoonPhaseImage.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 15/11/2023.
//

import Foundation
import SwiftUI

func FindMoonPhaseImage(moonPhase: String,
                        moonIllumination: Int) -> (String, Int) {
    
    var image: String = ""
    var daysToFullMoon: Int = 0
    
    if moonPhase == String(localized: "New Moon") {
        if moonIllumination == 0 {
            image = "New Moon"
            daysToFullMoon = 14
        }
    } else if moonPhase == String(localized: "Waxing Crescent") {
        if moonIllumination > 0,
           moonIllumination <= 3 {
            image = "Waxing Crescent 1"
            daysToFullMoon = 13
        } else if moonIllumination >  3,
                  moonIllumination <= 7 {
            image = "Waxing Crescent 2"
            daysToFullMoon = 12
        } else if moonIllumination >= 8,
                  moonIllumination <= 14 {
            image = "Waxing Crescent 3"
            daysToFullMoon = 11
        } else if moonIllumination >= 15,
                  moonIllumination <= 23 {
            image = "Waxing Crescent 4"
            daysToFullMoon = 10
        } else if moonIllumination > 23,
                  moonIllumination <= 33 {
            image = "Waxing Crescent 5"
            daysToFullMoon = 9
        } else if moonIllumination >  33,
                  moonIllumination <= 44 {
            image = "Waxing Crescent 6"
            daysToFullMoon = 8
        }
    } else if moonPhase == String(localized: "First Quarter") {
        if moonIllumination >= 45,
           moonIllumination <= 55 {
            image = "First Quarter"
            daysToFullMoon = 7
        }
    } else if moonPhase == String(localized: "Waxing gibbous") {
        if moonIllumination >= 56 ,
           moonIllumination <= 66 {
            image = "Waxing gibbous 1"
            daysToFullMoon = 6
        } else if moonIllumination >= 67,
                  moonIllumination <= 76 {
            image = "Waxing gibbous 2"
            daysToFullMoon = 5
        } else if moonIllumination >= 77,
                  moonIllumination <= 85 {
            image = "Waxing gibbous 3"
            daysToFullMoon = 4
        } else if moonIllumination >= 86,
                  moonIllumination <= 92 {
            image = "Waxing gibbous 4"
            daysToFullMoon = 3
        } else if moonIllumination >= 93,
                  moonIllumination <= 97 {
            image = "Waxing gibbous 5"
            daysToFullMoon = 2
        } else if moonIllumination >= 98,
                  moonIllumination <= 100 {
            image = "Waxing gibbous 6"
            daysToFullMoon = 1
        }
    } else if moonPhase == String(localized: "Full Moon") {
        if moonIllumination == 100 {
            image = "Full Moon"
            daysToFullMoon = 30
        }
    } else if moonPhase == String(localized: "Waning Gibbous") {
        if moonIllumination < 100 ,
           moonIllumination >= 97 {
            image = "Waning Gibbous 1"
            daysToFullMoon = 29
        } else if moonIllumination < 97 ,
                  moonIllumination >= 93 {
            image = "Waning Gibbous 2"
            daysToFullMoon = 28
        } else if moonIllumination < 93 ,
                  moonIllumination >= 87 {
            image = "Waning Gibbous 3"
            daysToFullMoon = 27
        } else if moonIllumination < 87,
                  moonIllumination >= 80 {
            image = "Waning Gibbous 4"
            daysToFullMoon = 26
        } else if moonIllumination <= 79,
                  moonIllumination >= 72 {
            image = "Waning Gibbous 5"
            daysToFullMoon = 25
        } else if moonIllumination <= 71,
                  moonIllumination >= 63 {
            image = "Waning Gibbous 6"
            daysToFullMoon = 24
        } else if moonIllumination <= 62,
                  moonIllumination >= 54 {
            image = "Waning Gibbous 7"
            daysToFullMoon = 23
        }
    } else if moonPhase == String(localized: "Last Quarter") {
        if moonIllumination <= 53,
           moonIllumination >= 44 {
            image = "Last Quarter"
            daysToFullMoon = 22
        }
    } else if moonPhase == String(localized: "Waning Crescent") {
        if moonIllumination <= 43,
           moonIllumination >= 35 {
            image = "Waning Crescent 1"
            daysToFullMoon = 21
        } else if moonIllumination <= 34,
                  moonIllumination >= 26 {
            image = "Waning Crescent 2"
            daysToFullMoon = 20
        } else if moonIllumination <= 25,
                  moonIllumination >= 18 {
            image = "Waning Crescent 3"
            daysToFullMoon = 19
        } else if moonIllumination <= 17,
                  moonIllumination >= 11 {
            image = "Waning Crescent 4"
            daysToFullMoon = 18
        } else if moonIllumination <= 10,
                  moonIllumination >= 5 {
            image = "Waning Crescent 5"
            daysToFullMoon = 17
        } else if moonIllumination < 5,
                  moonIllumination >= 2 {
            image = "Waning Crescent 6"
            daysToFullMoon = 16
        } else if moonIllumination <= 1,
                  moonIllumination > 0 {
            image = "Waning Crescent 7"
            daysToFullMoon = 15
        }
    }
    
    return (image, daysToFullMoon)
}

