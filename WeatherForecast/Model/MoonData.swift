 //
 //  MoonData.swift
 //  WeatherForecast
 //
 //  Created by Jan Hovland on 24/09/2025.
 //

class MoonData {
    var phase: String
    var moonMajorPhase: String
    var emoji: String
    var illumination: String
    var daysUntilNextFullMoon: Int
    var moonrise: String
    var moonset: String
    var distance: Double
    
    init(phase: String,
         moonMajorPhase: String,
         emoji: String,
         illumination: String,
         daysUntilNextFullMoon: Int,
         moonrise: String,
         moonset: String,
         distance: Double) {
        
        self.phase = phase
        self.moonMajorPhase = moonMajorPhase
        self.emoji = emoji
        self.illumination = illumination
        self.daysUntilNextFullMoon = daysUntilNextFullMoon
        self.moonrise = moonrise
        self.moonset = moonset
        self.distance = distance
    }
    
    convenience init(moonrise: String) {
        self.init(phase: "",
                  moonMajorPhase: "",
                  emoji: "",
                  illumination: "",
                  daysUntilNextFullMoon: 0,
                  moonrise: "",
                  moonset: "",
                  distance: 0.00)
    }
}
