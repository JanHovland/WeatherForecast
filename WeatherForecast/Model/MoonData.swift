 //
 //  MoonData.swift
 //  WeatherForecast
 //
 //  Created by Jan Hovland on 24/09/2025.
 //

class MoonData {
    var phaseName: String
    var majorPhase: String
    var phase: Double
    var stage: String
    var moonSign: String
    var emoji: String
    var illumination: String
    var daysUntilNextFullMoon: Int
    var moonrise: String
    var moonset: String
    var distance: Double
    
    init(phaseName: String,
         majorPhase: String,
         phase: Double,
         stage: String,
         moonSign: String,
         emoji: String,
         illumination: String,
         daysUntilNextFullMoon: Int,
         moonrise: String,
         moonset: String,
         distance: Double) {
        
        self.phaseName = phaseName
        self.majorPhase = majorPhase
        self.phase = phase
        self.stage = stage
        self.moonSign = moonSign
        
        self.emoji = emoji
        self.illumination = illumination
        self.daysUntilNextFullMoon = daysUntilNextFullMoon
        self.moonrise = moonrise
        self.moonset = moonset
        self.distance = distance
    }
    
    convenience init(moonrise: String) {
        self.init(phaseName: "",
                  majorPhase: "",
                  phase: 0.00,
                  stage: "",
                  moonSign: "",
                  emoji: "",
                  illumination: "",
                  daysUntilNextFullMoon: 0,
                  moonrise: "",
                  moonset: "",
                  distance: 0.00)
    }
}
