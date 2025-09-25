//
//  EmojiForPhase.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 24/09/2025.
//

import Foundation

func emojiForPhase(_ phaseName: String) -> String {
    let key = phaseName.lowercased()
    switch key {
    case "new moon": return "🌑"
    case "waxing crescent": return "🌒"
    case "first quarter": return "🌓"
    case "waxing gibbous": return "🌔"
    case "full moon": return "🌕"
    case "waning gibbous": return "🌖"
    case "last quarter", "third quarter": return "🌗"
    case "waning crescent": return "🌘"
    default: return "🌙"
    }
}
