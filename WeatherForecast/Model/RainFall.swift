//
//  RainFall.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 27/11/2022.
//

import Foundation

struct RainFall {
    var type : String = ""
    var data : [DataInfo] = [] 
}

struct DataInfo {
    var type: String = ""
    var index: Int = 0
    var amount : Double = 0.00
}

 
