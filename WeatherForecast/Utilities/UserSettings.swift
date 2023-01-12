//
//  File.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    @Published var keyOpenCage: String {
        didSet {
            UserDefaults.standard.set(keyOpenCage, forKey: "KeyOpenCage")
        }
    }
    
    @Published var urlOpenCage: String {
        didSet {
            UserDefaults.standard.set(urlOpenCage, forKey: "UrlOpenCage")
        }
    }
    
    @Published var keyOpenWeatherMap: String {
        didSet {
            UserDefaults.standard.set(keyOpenWeatherMap, forKey: "KeyOpenWeatherMap")
        }
    }
    
    @Published var urlOpenWeatherMap1: String {
        didSet {
            UserDefaults.standard.set(urlOpenWeatherMap1, forKey: "UrlOpenWeatherMap1")
        }
    }
    
    @Published var urlOpenWeatherMap2: String {
        didSet {
            UserDefaults.standard.set(urlOpenWeatherMap2, forKey: "UrlOpenWeatherMap2")
        }
    }
    
    @Published var urlMetNo: String {
        didSet {
            UserDefaults.standard.set(urlMetNo, forKey: "UrlMetNo")
        }
    }
    
    init() {
        self.keyOpenCage = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
        self.urlOpenCage = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
        self.keyOpenWeatherMap = UserDefaults.standard.object(forKey: "KeyOpenWeatherMap") as? String ?? ""
        self.urlOpenWeatherMap1 = UserDefaults.standard.object(forKey: "UrlOpenWeatherMap1") as? String ?? ""
        self.urlOpenWeatherMap2 = UserDefaults.standard.object(forKey: "UrlOpenWeatherMap2") as? String ?? ""
        self.urlMetNo = UserDefaults.standard.object(forKey: "UrlMetNo") as? String ?? ""
    }
    
}
