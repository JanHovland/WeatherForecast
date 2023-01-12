//
//  TranslateWeatherCondition.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 14/10/2022.
//

import Foundation

func TranslateWeatherCondition(condition: String) -> String {
    
    switch condition {
        /// Blizzard.
    case "blizzard":
        return String(localized: "blizzard")
        /// Blowing dust or sandstorm.
    case "blowingDust":
        return String(localized: "blowingDust")
        /// Blowing or drifting snow.
    case "blowingSnow":
        return String(localized: "blowingSnow")
        /// Breezy, light wind.
    case "breezy":
        return String(localized: "breezy")
        /// Clear.
    case "clear":
        return String(localized: "clear")
        /// Cloudy, overcast conditions.
    case "cloudy":
        return String(localized: "cloudy")
        /// Drizzle or light rain.
    case "drizzle":
        return String(localized: "drizzle")
        /// Flurries or light snow.
    case "flurries":
        return String(localized: "flurries")
        /// Fog.
    case "foggy":
        return String(localized: "foggy")
        /// Freezing drizzle or light rain.
    case "freezingDrizzle":
        return String(localized: "freezingDrizzle")
        /// Freezing rain.
    case "freezingRain":
        return String(localized: "freezingRain")
        /// Frigid conditions, low temperatures, or ice crystals.
    case "frigid":
        return String(localized: "frigid")
        /// Hail.
    case "hail":
        return String(localized: "hail")
        /// Haze.
    case "haze":
        return String(localized: "haze")
        /// Heavy rain.
    case "heavyRain":
        return String(localized: "heavyRain")
        /// Heavy snow.
    case "heavySnow":
        return String(localized: "heavySnow")
        /// High temperatures.
    case "hot":
        return String(localized: "hot")
        /// Hurricane.
    case "hurricane":
        return String(localized: "Hurricane")
        /// Thunderstorms covering less than 1/8 of the forecast area.
    case "isolatedThunderstorms":
        return String(localized: "isolatedThunderstorms")
        /// Mostly clear.
    case "mostlyClear":
        return String(localized: "mostlyClear")
        /// Mostly cloudy.
    case "mostlyCloudy":
        return String(localized: "mostlyCloudy")
        /// Partly cloudy.
    case "partlyCloudy":
        return String(localized: "partlyCloudy")
        /// Rain.
    case "rain":
        return String(localized: "rain")
        /// Numerous thunderstorms spread across up to 50% of the forecast area.
    case "scatteredThunderstorms":
        return String(localized: "scatteredThunderstorms")
        /// Sleet.
    case "sleet":
        return String(localized: "sleet")
        /// Smoky.
    case "smoky":
        return String(localized: "smoky")
        /// Snow.
    case "snow":
        return String(localized: "snow")
        /// Notably strong thunderstorms.
    case "strongStorms":
        return String(localized: "strongStorms")
        /// Snow flurries with visible sun.
    case "sunFlurries":
        return String(localized: "sunFlurries")
        /// Rain with visible sun.
    case "sunShowers":
        return String(localized: "sunShowers")
        /// Thunderstorms.
    case "thunderstorms":
        return String(localized: "thunderstorms")
        /// Tropical storm.
    case "tropicalStorm":
        return String(localized: "tropicalStorm")
        /// Windy.
    case "windy":
        return String(localized: "windy")
        /// Wintry mix.
    case "wintryMix":
        return String(localized: "wintryMix")
    default:
        return ""
    }
}

