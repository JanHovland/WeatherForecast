//
//  FindChartDataPrecipitation.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 21/10/2023.
//

import SwiftUI
import WeatherKit

func FindChartDataPrecipitation(weather: Weather,
                                date: Date,
                                option: EnumType) -> (new: [NewPrecipitation],
                                                      min: Double,
                                                      max: Double,
                                                      minIndex: Int,
                                                      maxIndex: Int,
                                                      rangeFrom: Int,
                                                      rangeTo: Int) {
    
    var new: [NewPrecipitation] = []
    let min: Double = 0.00
    var max: Double = 0.00
    let minIndex: Int = 0
    let maxIndex: Int = 0
    var rangeFrom: Int = 0
    var rangeTo: Int = 0
    
    var rainFaal: [RainFall]
    
    let value : ([Double],
                 [String],
                 [String],
                 [RainFall],
                 [WindInfo],
                 [Temperature],
                 [Double],
                 [WeatherIcon],
                 [Double],
                 [FeltTemp],
                 [Double],
                 [NewData]) = FindDataFromMenu(info: "FindChartDataPrecipitation",
                                               weather: weather,
                                               date: date,
                                               option: option,
                                               option1: .number24)
    rainFaal = value.3
    new.removeAll()
    ///
    /// Må initialisere n:
    ///
    var n: NewPrecipitation = NewPrecipitation(type: "", hour: 0, value: 0.00)
    ///
    /// Finder "Rain":
    ///
    for i in 0..<rainFaal[rainType].data.count {
//    for i in 0..<24 {
        n.type = String(localized: "Rain")
        n.hour = i
        n.value = rainFaal[rainType].data[i].amount
        if n.value > max {
            max = n.value
        }
        new.append(n)
    }
    ///
    /// Finder "Sleet":
    ///
//    for i in 0..<rainFaal[sleetType].data.count {
//        n.type = String(localized: "Sleet")
//        n.hour = i
//        n.value = rainFaal[sleetType].data[i].amount
//        if n.value > max {
//            max = n.value
//        }
//        new.append(n)
//    }
//    ///
//    /// Finder "Mixed":
//    ///
//    for i in 0..<rainFaal[mixedType].data.count {
//        n.type = String(localized: "Mixed")
//        n.hour = i
//        n.value = rainFaal[mixedType].data[i].amount
//        if n.value > max {
//            max = n.value
//        }
//        new.append(n)
//    }
//    ///
//    /// Finder "Snow":
//    ///
//    for i in 0..<rainFaal[snowType].data.count {
//        n.type = String(localized: "Snow")
//        n.hour = i
//        n.value = rainFaal[snowType].data[i].amount
//        if n.value > max {
//            max = n.value
//        }
//        new.append(n)
//    }
//    ///
//    /// Finder "Hail":
//    ///
//    for i in 0..<rainFaal[hailType].data.count {
//        n.type = String(localized: "Hail")
//        n.hour = i
//        n.value = rainFaal[hailType].data[i].amount
//        if n.value > max {
//            max = n.value
//        }
//        new.append(n)
//    }
    ///
    /// Beregner rangeFrom
    ///
    rangeFrom = 0
    ///
    /// Må beregne rangeTo som er den  maksibale verdien av alle typene
    ///
    rangeTo = Int(max) + 1
    
  
    return (new, min, max, minIndex, maxIndex, rangeFrom, rangeTo)
}

/*
 Printing description of new:
 ▿ 120 elements
   ▿ 0 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 0
     - value : 0.0
   ▿ 1 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 1
     - value : 0.2
   ▿ 2 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 2
     - value : 0.5
   ▿ 3 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 3
     - value : 0.4
   ▿ 4 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 4
     - value : 0.3
   ▿ 5 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 5
     - value : 0.2
   ▿ 6 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 6
     - value : 0.2
   ▿ 7 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 7
     - value : 0.0
   ▿ 8 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 8
     - value : 0.2
   ▿ 9 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 9
     - value : 0.0
   ▿ 10 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 10
     - value : 0.0
   ▿ 11 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 11
     - value : 0.3
   ▿ 12 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 12
     - value : 0.0
   ▿ 13 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 13
     - value : 0.0
   ▿ 14 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 14
     - value : 0.0
   ▿ 15 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 15
     - value : 0.0
   ▿ 16 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 16
     - value : 0.0
   ▿ 17 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 17
     - value : 0.0
   ▿ 18 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 18
     - value : 0.0
   ▿ 19 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 19
     - value : 0.0
   ▿ 20 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 20
     - value : 0.0
   ▿ 21 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 21
     - value : 0.0
   ▿ 22 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 22
     - value : 0.0
   ▿ 23 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Nedbør"
     - hour : 23
     - value : 0.0
   ▿ 24 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 0
     - value : 0.0
   ▿ 25 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 1
     - value : 0.0
   ▿ 26 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 2
     - value : 0.0
   ▿ 27 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 3
     - value : 0.0
   ▿ 28 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 4
     - value : 0.0
   ▿ 29 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 5
     - value : 0.0
   ▿ 30 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 6
     - value : 0.0
   ▿ 31 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 7
     - value : 0.0
   ▿ 32 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 8
     - value : 0.0
   ▿ 33 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 9
     - value : 0.0
   ▿ 34 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 10
     - value : 0.0
   ▿ 35 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 11
     - value : 0.0
   ▿ 36 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 12
     - value : 0.0
   ▿ 37 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 13
     - value : 0.0
   ▿ 38 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 14
     - value : 0.0
   ▿ 39 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 15
     - value : 0.0
   ▿ 40 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 16
     - value : 0.0
   ▿ 41 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 17
     - value : 0.0
   ▿ 42 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 18
     - value : 0.0
   ▿ 43 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 19
     - value : 0.0
   ▿ 44 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 20
     - value : 0.0
   ▿ 45 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 21
     - value : 0.0
   ▿ 46 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 22
     - value : 0.0
   ▿ 47 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Sludd"
     - hour : 23
     - value : 0.0
   ▿ 48 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 0
     - value : 0.0
   ▿ 49 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 1
     - value : 0.0
   ▿ 50 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 2
     - value : 0.0
   ▿ 51 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 3
     - value : 0.0
   ▿ 52 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 4
     - value : 0.0
   ▿ 53 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 5
     - value : 0.0
   ▿ 54 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 6
     - value : 0.0
   ▿ 55 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 7
     - value : 0.0
   ▿ 56 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 8
     - value : 0.0
   ▿ 57 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 9
     - value : 0.0
   ▿ 58 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 10
     - value : 0.0
   ▿ 59 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 11
     - value : 0.0
   ▿ 60 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 12
     - value : 0.0
   ▿ 61 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 13
     - value : 0.0
   ▿ 62 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 14
     - value : 0.0
   ▿ 63 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 15
     - value : 0.0
   ▿ 64 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 16
     - value : 0.0
   ▿ 65 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 17
     - value : 0.0
   ▿ 66 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 18
     - value : 0.0
   ▿ 67 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 19
     - value : 0.0
   ▿ 68 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 20
     - value : 0.0
   ▿ 69 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 21
     - value : 0.0
   ▿ 70 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 22
     - value : 0.0
   ▿ 71 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Blandet nedbør"
     - hour : 23
     - value : 0.0
   ▿ 72 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 0
     - value : 0.0
   ▿ 73 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 1
     - value : 0.0
   ▿ 74 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 2
     - value : 0.0
   ▿ 75 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 3
     - value : 0.0
   ▿ 76 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 4
     - value : 0.0
   ▿ 77 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 5
     - value : 0.0
   ▿ 78 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 6
     - value : 0.0
   ▿ 79 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 7
     - value : 0.0
   ▿ 80 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 8
     - value : 0.0
   ▿ 81 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 9
     - value : 0.0
   ▿ 82 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 10
     - value : 0.0
   ▿ 83 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 11
     - value : 0.0
   ▿ 84 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 12
     - value : 0.0
   ▿ 85 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 13
     - value : 0.0
   ▿ 86 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 14
     - value : 0.0
   ▿ 87 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 15
     - value : 0.0
   ▿ 88 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 16
     - value : 0.0
   ▿ 89 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 17
     - value : 0.0
   ▿ 90 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 18
     - value : 0.0
   ▿ 91 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 19
     - value : 0.0
   ▿ 92 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 20
     - value : 0.0
   ▿ 93 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 21
     - value : 0.0
   ▿ 94 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 22
     - value : 0.0
   ▿ 95 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Snø"
     - hour : 23
     - value : 0.0
   ▿ 96 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 0
     - value : 0.0
   ▿ 97 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 1
     - value : 0.0
   ▿ 98 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 2
     - value : 0.0
   ▿ 99 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 3
     - value : 0.0
   ▿ 100 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 4
     - value : 0.0
   ▿ 101 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 5
     - value : 0.0
   ▿ 102 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 6
     - value : 0.0
   ▿ 103 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 7
     - value : 0.0
   ▿ 104 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 8
     - value : 0.0
   ▿ 105 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 9
     - value : 0.0
   ▿ 106 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 10
     - value : 0.0
   ▿ 107 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 11
     - value : 0.0
   ▿ 108 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 12
     - value : 0.0
   ▿ 109 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 13
     - value : 0.0
   ▿ 110 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 14
     - value : 0.0
   ▿ 111 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 15
     - value : 0.0
   ▿ 112 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 16
     - value : 0.0
   ▿ 113 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 17
     - value : 0.0
   ▿ 114 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 18
     - value : 0.0
   ▿ 115 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 19
     - value : 0.0
   ▿ 116 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 20
     - value : 0.0
   ▿ 117 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 21
     - value : 0.0
   ▿ 118 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 22
     - value : 0.0
   ▿ 119 : NewPrecipitation
     - id : 465C0C66-F2E1-46D8-9CAB-83E632144223
     - type : "Hagl"
     - hour : 23
     - value : 0.0
 */
