//
//  FindDataFromMenu.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 04/11/2022.
//

import SwiftUI
import WeatherKit


func FindDataFromMenu(info: String,
                      weather: Weather,
                      date: Date,
                      option: EnumType,
                      option1: EnumType) -> ([Double],
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
                                             [NewPrecipitation])  {
    
    var array : [Double] = Array(repeating: Double(), count: sizeArray24)
    var arrayDayIcons : [String] = Array(repeating: String(), count: sizeArray10)
    var arrayHourIcons : [String] = Array(repeating: String(), count: sizeArray24)
    var hourIconArray : [String] = Array(repeating: String(), count: sizeArray24)
    var windInfoArray : [WindInfo] = Array(repeating: WindInfo(), count: sizeArray24)
    var tempInfoArray : [Temperature] = Array(repeating: Temperature(), count: sizeArray24)
    var gustInfoArray : [Double] = Array(repeating: Double(), count: sizeArray24)
    var weatherIconArray: [WeatherIcon] = Array(repeating: WeatherIcon(), count: sizeArray24)
    var snowArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    var feltTempArray: [FeltTemp] = Array(repeating: FeltTemp(), count: sizeArray24)
    var dewPointArray: [Double] = Array(repeating: Double(), count: sizeArray24)
    var nData = NewPrecipitation(type: "", hour: 0, value: 0.00, apparentPrecipitationIntensity: "")
    var newPrecipitation : [NewPrecipitation] = []
    var hailData : [DataInfo] = []
    var mixedData : [DataInfo] = []
    var rainData : [DataInfo] = []
    var sleetData : [DataInfo] = []
    var snowData : [DataInfo] = []
    var windSpeedData : [DataWind] = []
    var windGustData : [DataWind] = []

    var tempData: [TempData] = []
    var appearentData: [TempData] = []
    
    var iconData: [IconData] = []
    var windData: [IconData] = []
    var humidityData: [IconData] = []
    var visibilityData: [IconData] = []
    var airpressureData: [IconData] = []

    var rainFall  = RainFall()
    var rainFalls : [RainFall] = []
    var weatherIcon = WeatherIcon()
    
    var tempInfo = Temperature()
    var gustInfo : Double = 0.00
    
    var windInfo = WindInfo()
    
    rainFalls.removeAll()
    let value : (Date,Date) = DateRange(date: date)
    
    array.removeAll()
    arrayDayIcons.removeAll()
    arrayHourIcons.removeAll()
    hourIconArray.removeAll()
    
    hailData.removeAll()
    mixedData.removeAll()
    rainData.removeAll()
    sleetData.removeAll()
    snowData.removeAll()
    windSpeedData.removeAll()
    windGustData.removeAll()
    
    iconData.removeAll()
    windData.removeAll()
    humidityData.removeAll()
    visibilityData.removeAll()
    airpressureData.removeAll()

    rainFalls.removeAll()
    tempInfoArray.removeAll()
    windInfoArray.removeAll()
    gustInfoArray.removeAll()
    weatherIconArray.removeAll()
    snowArray.removeAll()
    feltTempArray.removeAll()
    dewPointArray.removeAll()
    newPrecipitation.removeAll()
    
    if hourForecast == nil {
         
    }
    switch option {
    case .temperature :
        var i: Int = 0
        var data = TempData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append($0.temperature.value)
                arrayHourIcons.append(convertImageToFill(image: $0.symbolName))
                ///
                /// Oppdaterer vanlig temperatur:
                ///
                data = TempData()
                data.index = i
                data.temp = $0.temperature.value
                data.gust = $0.wind.gust!.value * 1000 / 3600
                data.wind = $0.wind.speed.value * 1000 / 3600
                data.condition = WeatherTranslateType(type: $0.condition.description)
                data.symbolName = $0.symbolName
                tempData.append(data)
                ///
                /// Oppdaterer følt  temperatur:
                ///
                data = TempData()
                data.index = i
                data.temp = $0.apparentTemperature.value
                data.gust = $0.wind.gust!.value * 1000 / 3600
                data.wind = $0.wind.speed.value * 1000 / 3600
                data.condition = WeatherTranslateType(type: $0.condition.description)
                data.symbolName = $0.symbolName
                appearentData.append(data)
                i = i + 1
            }
        }
        ///
        /// Oppdaterer tempInfoArray:
        ///
        tempInfo.type = String(localized: "Temperature")
        tempInfo.data = tempData
        tempInfoArray.append(tempInfo)
        
        tempInfo.type = String(localized: "Appearent temperature")
        tempInfo.data = appearentData
        tempInfoArray.append(tempInfo)
        
        weather.dailyForecast.forEach  {
           arrayDayIcons.append(convertImageToFill(image: $0.symbolName))
        }
//        arrayHourIcons = reduceArrayAmount(fromArray: arrayHourIcons, option: option1)
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .uvIndex :
        var i: Int = 0
        var data = IconData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append(Double($0.uvIndex.value))
                arrayHourIcons.append(String($0.uvIndex.value))
                ///
                /// Oppdaterer iconData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.uvIndex.value)")
                if option1 == .number24 {
                    iconData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        iconData.append(data)
                    }
                }
                ///
                /// Oppdaterer windData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.wind.direction.value)")
                if option1 == .number24 {
                    windData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        windData.append(data)
                    }
                }
                ///
                /// Oppdaterer humidityData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\(Int($0.humidity * 100))")
                if option1 == .number24 {
                    humidityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        humidityData.append(data)
                    }
                }
                ///
                ///  Oppdaterer visibilityData:
                ///
                data = IconData()
                data.index = i
                data.icon = "\(Int($0.visibility.value / 1000.0.rounded()))"
                if option1 == .number24 {
                    visibilityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        visibilityData.append(data)
                    }
                }
                ///
                /// Oppdaterer airpressureData:
                ///
                data = IconData()
                data.index = i
                let trend = $0.pressureTrend.description
                if trend == "Fallende" {
                    data.icon = "arrow.down.to.line.compact"
                } else if trend == "Uendret" {
                    data.icon = "equal"
                } else {
                    data.icon = "arrow.up.to.line.compact"
                }
                if option1 == .number24 {
                    airpressureData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        airpressureData.append(data)
                    }
                }

                i = i + 1
            }
        }
        ///
        /// Oppdaterer weatherIconArray
        ///
        weatherIcon.type = uvIconType
        weatherIcon.data = iconData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = windIconType
        weatherIcon.data = windData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = humidityIconType
        weatherIcon.data = humidityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = visibilityIconType
        weatherIcon.data = visibilityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = airpressureIconType
        weatherIcon.data = airpressureData
        weatherIconArray.append(weatherIcon)
        
        weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        arrayHourIcons = reduceArrayAmount(fromArray:arrayHourIcons, option: option1)
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .wind :
        var i: Int = 0
        var data = DataWind()
        var data1 = IconData()
        var data2 = TempData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                ///
                /// Oppdaterer vindhastigheten:
                ///
                array.append($0.wind.speed.value  * 1000 / 3600)
                data = DataWind()
                ///
                /// Oppdaterer windInfoArray:
                ///
                data.index = i
                data.amount = $0.wind.speed.value * 1000 / 3600
                data.direction = $0.wind.direction.value
                
                arrayHourIcons.append(String($0.wind.direction.value))

                
                windSpeedData.append(data)
                
                data = DataWind()
                data.index = i
                data.amount = $0.wind.gust!.value * 1000 / 3600
                data.direction = 0.00
                windGustData.append(data)
                ///
                /// Oppdaterer gustInfoArray:
                ///
                if ($0.wind.gust == nil) {
                    gustInfo = 0.00
                } else {
                    gustInfo = $0.wind.gust!.value * 1000 / 3600
                }
                gustInfoArray.append(gustInfo)
                
                ///
                /// Oppdaterer iconData:
                ///
                data1 = IconData()
                data1.index = i
                data1.icon = String("\($0.symbolName)")
                if option1 == .number24 {
                    iconData.append(data1)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        iconData.append(data1)
                    }
                }
                ///
                /// Oppdaterer windData:
                ///
                data1 = IconData()
                data1.index = i
                data1.icon = String("\($0.wind.direction.value)")
                
                if option1 == .number24 {
                    windData.append(data1)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        windData.append(data1)
                    }
                }
                ///
                /// Oppdaterer humidityData:
                ///
                data1 = IconData()
                data1.index = i
                data1.icon = String("\(Int($0.humidity * 100))")
                if option1 == .number24 {
                    humidityData.append(data1)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        humidityData.append(data1)
                    }
                }
                ///
                ///  Oppdaterer visibilityData:
                ///
                data1 = IconData()
                data1.index = i
                data1.icon = "\(Int($0.visibility.value / 1000.0.rounded()))"
                if option1 == .number24 {
                    visibilityData.append(data1)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        visibilityData.append(data1)
                    }
                }
                ///
                /// Oppdaterer airpressureData:
                ///
                data1 = IconData()
                data1.index = i
                let trend = $0.pressureTrend.description
                if trend == "Fallende" {
                    data1.icon = "arrow.down.to.line.compact"
                } else if trend == "Uendret" {
                    data1.icon = "equal"
                } else {
                    data1.icon = "arrow.up.to.line.compact"
                }
                if option1 == .number24 {
                    airpressureData.append(data1)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        airpressureData.append(data1)
                    }
                }
                ///
                /// Oppdaterer vind og vindkast::
                ///
                data2 = TempData()
                data2.index = i
                data2.temp = $0.temperature.value
                data2.gust = $0.wind.gust!.value * 1000 / 3600
                data2.wind = $0.wind.speed.value * 1000 / 3600
                data2.condition = WeatherTranslateType(type: $0.condition.description)
                tempData.append(data2)
                i = i + 1
            }
        }
        ///
        /// Oppdaterer windInfoArray:
        ///
        windInfo.type = String(localized: "WindSpeed")
        windInfo.data = windSpeedData
        windInfoArray.append(windInfo)
        
        windInfo.type = String(localized: "GustSpeed")
        windInfo.data = windGustData
        windInfoArray.append(windInfo)
        ///
        /// Oppdaterer weatherIconArray
        ///
        weatherIcon.type = uvIconType
        weatherIcon.data = iconData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = windIconType
        weatherIcon.data = windData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = humidityIconType
        weatherIcon.data = humidityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = visibilityIconType
        weatherIcon.data = visibilityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = airpressureIconType
        weatherIcon.data = airpressureData
        weatherIconArray.append(weatherIcon)
        ///
        /// Oppdaterer arrayDayIcons:
        ///
        weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        arrayHourIcons = reduceArrayAmount(fromArray: arrayHourIcons, option: option1)
        ///
        /// Oppdaterer tempInfoArray:
        ///
        tempInfo.type = String(localized: "Wind")
        tempInfo.data = tempData
        tempInfoArray.append(tempInfo)
        
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .precipitation :
        var i: Int = 0
        var dataInfo = DataInfo()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date <  value.1 {
                array.append($0.precipitationAmount.value)
                dataInfo.index = i
                if $0.precipitationAmount.value > 0.00 {
                    nData.type = $0.precipitation.description.firstUppercased
                    nData.hour = i
                    nData.value = $0.precipitationAmount.value
                    nData.apparentPrecipitationIntensity = classifyPrecipitationIntensity(mmPerHour: $0.precipitationAmount.value)
                    newPrecipitation.append(nData)
                } else {
                    nData.type = String(localized: "Dry")
                    nData.hour = i
                    nData.value = 0.00
                    nData.apparentPrecipitationIntensity = classifyPrecipitationIntensity(mmPerHour: $0.precipitationAmount.value)
                    newPrecipitation.append(nData)
                }
                i = i + 1
            }
        }
//        arrayHourIcons = reduceArrayAmount(fromArray:arrayHourIcons, option: option1)
//        
//        weather.dailyForecast.forEach  {
//            arrayDayIcons.append($0.symbolName)
//        }
        
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .feelsLike :
        var i: Int = 0
        var data = TempData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append($0.temperature.value)
                arrayHourIcons.append($0.symbolName)
                ///
                /// Oppdaterer vanlig temperatur:
                ///
                data = TempData()
                data.index = i
                data.temp = $0.temperature.value
                data.gust = $0.wind.gust!.value * 1000 / 3600
                data.wind = $0.wind.speed.value * 1000 / 3600
                data.condition = WeatherTranslateType(type: $0.condition.description)
                tempData.append(data)
                ///
                /// Oppdaterer følt  temperatur:
                ///
                data = TempData()
                data.index = i
                data.temp = $0.apparentTemperature.value
                data.gust = $0.wind.gust!.value * 1000 / 3600
                data.wind = $0.wind.speed.value * 1000 / 3600
                data.condition = WeatherTranslateType(type: $0.condition.description)
                appearentData.append(data)
                i = i + 1
            }
        }
        ///
        /// Oppdaterer tempInfoArray:
        ///
        tempInfo.type = String(localized: "Appearent temperature")
        tempInfo.data = appearentData
        tempInfoArray.append(tempInfo)
        
        tempInfo.type = String(localized: "Temperature")
        tempInfo.data = tempData
        tempInfoArray.append(tempInfo)
        
       weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        arrayHourIcons = reduceArrayAmount(fromArray: arrayHourIcons, option: option1)
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .humidity :
        var i: Int = 0
        var data = IconData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append($0.humidity * 100)
                ///
                /// Opdaterer dewPoint:
                /// 
                dewPointArray.append($0.dewPoint.value)
                arrayHourIcons.append(String(Int($0.humidity * 100)))
                ///
                /// Oppdaterer iconData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.uvIndex.value)")
                if option1 == .number24 {
                    iconData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        iconData.append(data)
                    }
                }
                ///
                /// Oppdaterer windData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.wind.direction.value)")
                if option1 == .number24 {
                    windData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        windData.append(data)
                    }
                }
                ///
                /// Oppdaterer humidityData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\(Int($0.humidity * 100))")
                if option1 == .number24 {
                    humidityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        humidityData.append(data)
                    }
                }
                ///
                ///  Oppdaterer visibilityData:
                ///
                data = IconData()
                data.index = i
                data.icon = "\(Int($0.visibility.value / 1000.0.rounded()))"
                if option1 == .number24 {
                    visibilityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        visibilityData.append(data)
                    }
                }
                ///
                /// Oppdaterer airpressureData:
                ///
                data = IconData()
                data.index = i
                let trend = $0.pressureTrend.description
                if trend == "Fallende" {
                    data.icon = "arrow.down.to.line.compact"
                } else if trend == "Uendret" {
                    data.icon = "equal"
                } else {
                    data.icon = "arrow.up.to.line.compact"
                }
                if option1 == .number24 {
                    airpressureData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        airpressureData.append(data)
                    }
                }

                i = i + 1
                
            }
        }
        
        ///
        /// Oppdaterer weatherIconArray
        ///
        weatherIcon.type = uvIconType
        weatherIcon.data = iconData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = windIconType
        weatherIcon.data = windData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = humidityIconType
        weatherIcon.data = humidityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = visibilityIconType
        weatherIcon.data = visibilityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = airpressureIconType
        weatherIcon.data = airpressureData
        weatherIconArray.append(weatherIcon)

        weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        arrayHourIcons = reduceArrayAmount(fromArray:arrayHourIcons, option: option1)
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .visibility :
        var i: Int = 0
        var data = IconData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append($0.visibility.value / 1000.0)
                arrayHourIcons.append(String(Int($0.visibility.value / 1000.0)))
                ///
                /// Oppdaterer iconData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.uvIndex.value)")
                if option1 == .number24 {
                    iconData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        iconData.append(data)
                    }
                }
                ///
                /// Oppdaterer windData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.wind.direction.value)")
                if option1 == .number24 {
                    windData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        windData.append(data)
                    }
                }
                ///
                /// Oppdaterer humidityData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\(Int($0.humidity * 100))")
                if option1 == .number24 {
                    humidityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        humidityData.append(data)
                    }
                }
                ///
                ///  Oppdaterer visibilityData:
                ///
                data = IconData()
                data.index = i
                data.icon = "\(Int($0.visibility.value / 1000.0.rounded()))"
                if option1 == .number24 {
                    visibilityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        visibilityData.append(data)
                    }
                }
                ///
                /// Oppdaterer airpressureData:
                ///
                data = IconData()
                data.index = i
                let trend = $0.pressureTrend.description
                if trend == "Fallende" {
                    data.icon = "arrow.down.to.line.compact"
                } else if trend == "Uendret" {
                    data.icon = "equal"
                } else {
                    data.icon = "arrow.up.to.line.compact"
                }
                if option1 == .number24 {
                    airpressureData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        airpressureData.append(data)
                    }
                }

                i = i + 1
                
            }
        }
        weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        
        ///
        /// Oppdaterer weatherIconArray
        ///
        weatherIcon.type = uvIconType
        weatherIcon.data = iconData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = windIconType
        weatherIcon.data = windData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = humidityIconType
        weatherIcon.data = humidityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = visibilityIconType
        weatherIcon.data = visibilityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = airpressureIconType
        weatherIcon.data = airpressureData
        weatherIconArray.append(weatherIcon)
        
        arrayHourIcons = reduceArrayAmount(fromArray:arrayHourIcons, option: option1)
        
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    case .airPressure :
        var i: Int = 0
        var data = IconData()
        hourForecast!.forEach  {
            if $0.date >= value.0 &&
                $0.date < value.1 {
                array.append($0.pressure.value)
                ///
                /// Oppdaterer iconData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.uvIndex.value)")
                if option1 == .number24 {
                    iconData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        iconData.append(data)
                    }
                }
                ///
                /// Oppdaterer windData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\($0.wind.direction.value)")
                if option1 == .number24 {
                    windData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        windData.append(data)
                    }
                }
                ///
                /// Oppdaterer humidityData:
                ///
                data = IconData()
                data.index = i
                data.icon = String("\(Int($0.humidity * 100))")
                if option1 == .number24 {
                    humidityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        humidityData.append(data)
                    }
                }
                ///
                ///  Oppdaterer visibilityData:
                ///
                data = IconData()
                data.index = i
                data.icon = "\(Int($0.visibility.value / 1000.0.rounded()))"
                if option1 == .number24 {
                    visibilityData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        visibilityData.append(data)
                    }
                }
                ///
                /// Oppdaterer airpressureData:
                ///
                data = IconData()
                data.index = i
                let trend = $0.pressureTrend.description
                if trend == "Fallende" {
                    data.icon = "arrow.down.to.line.compact"
                } else if trend == "Uendret" {
                    data.icon = "equal"
                } else {
                    data.icon = "arrow.up.to.line.compact"
                }
                if option1 == .number24 {
                    airpressureData.append(data)
                } else if option1 == .number12 {
                    if i % 2 == 0 {
                        airpressureData.append(data)
                    }
                }
                ///
                /// Oppdaterer arrayHourIcons:
                ///
                arrayHourIcons.append(data.icon)

                i = i + 1
                
            }
        }
        weather.dailyForecast.forEach  {
            arrayDayIcons.append($0.symbolName)
        }
        
        ///
        /// Oppdaterer weatherIconArray
        ///
        weatherIcon.type = uvIconType
        weatherIcon.data = iconData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = windIconType
        weatherIcon.data = windData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = humidityIconType
        weatherIcon.data = humidityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = visibilityIconType
        weatherIcon.data = visibilityData
        weatherIconArray.append(weatherIcon)

        weatherIcon.type = airpressureIconType
        weatherIcon.data = airpressureData
        weatherIconArray.append(weatherIcon)
        
        arrayHourIcons = reduceArrayAmount(fromArray:arrayHourIcons, option: option1)
        return (array, arrayDayIcons, arrayHourIcons, rainFalls, windInfoArray, tempInfoArray, gustInfoArray, weatherIconArray, snowArray, feltTempArray, dewPointArray, newPrecipitation)
        
    default :
        return ([Double()], [String()], [String()], [RainFall](), [WindInfo](), [Temperature](), [Double](), [WeatherIcon](), [Double()], [FeltTemp](), [Double()], [NewPrecipitation(type: "0", hour: 0, value: 0.00)])
    }
    
}

func reduceArrayAmount (fromArray: [String], option: EnumType) -> [String] {

    var i : Int = 0
    var toArray: [String] = []
    toArray.removeAll()
    if option == .number24 {
        toArray = fromArray
    } else {
        for icon in fromArray {
            if (i % 2 == 0) {
                toArray.append(icon)
            }
            i = i + 1
        }
    }
    return toArray
}

// Classify hourly precipitation intensity by amount (mm per hour)
private func classifyPrecipitationIntensity(mmPerHour: Double) -> String {
    
    /// Begrep                                                              Typisk praktisk terskel (mm/time)
    /// Lett                                                                    < 2,5 mm/t
    /// Moderat                                                             ≈ 2,5 – 7,5 mm/t
    /// Kraftig / kraftig regn / sterk intensitet                ≥ 7,6 mm/t (og noen ganger: > 10 mm/t for «sterkt»)
    /// Ekstrem / skybrudd / voldsomt bygeregn          ≥ 50 mm/t (brukes for svært sjeldne, tropiske-type intensiteter)

    if mmPerHour <= 0.00 { return String(localized: "Dry") }
    if mmPerHour < 1.00 { return String(localized: "Light") }
    if mmPerHour < 4.0 { return String(localized: "Moderate") }
    if mmPerHour < 8.00 { return String(localized: "Heavy") }
    return String(localized: "Extreme")
}
