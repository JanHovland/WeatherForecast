//
//  MoonView.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 30/10/2023.
//

import SwiftUI

struct MoonView: View {
        @Environment(CurrentWeather.self) private var currentWeather

        var body: some View {
            VStack {
                ///
                /// Viser overskriften for fluftkvaliteten:
                ///
                HStack {
                    Image(systemName: "moon")
                        .renderingMode(.original)
                        .font(Font.headline.weight(.regular))
                    Text("MOON")
                        .font(.system(size: 15, weight: .bold))
                }
                .opacity(0.50)
                .padding(.leading, -40)
                Spacer()
            }
            .frame(width: UIDevice.isIpad ? 358 : 358,
                   height: UIDevice.isIpad ? 200 : 200)
            .padding(15)
            .modifier(DayDetailBackground(dayLight: currentWeather.isDaylight))
        }
    }

/*
 
 https://docs.api.met.no/doc/formats/SunriseJSON
 
 
 Sun (without DST):

 Blindern, Oslo
 https://api.met.no/weatherapi/sunrise/3.0/sun?lat=59.933333&lon=10.716667&date=2023-11-01&offset=+01:00

 New York
 https://api.met.no/weatherapi/sunrise/3.0/sun?lat=40.7127&lon=-74.0059&date=2023-11-01&offset=-05:00

 Moon (without DST):

 Blindern, Oslo
 https://api.met.no/weatherapi/sunrise/3.0/moon?lat=59.933333&lon=10.716667&date=2023-11-01&offset=+01:00

 New York
 https://api.met.no/weatherapi/sunrise/3.0/moon?lat=40.7127&lon=-74.0059&date=2023-11-01&offset=-05:00
 
 
 MOON PHASES
 Degrees    Descripton
 0    New moon
 0..90    Waxing crescent
 90..180    Waxing gibbous
 180    Full moon
 180..270    Waning gibbous
 270..360    Waning crescent

 
 MOON
 {
   "copyright": "MET Norway",
   "licenseURL": "https://api.met.no/license_data.html",
   "type": "Feature",
   "geometry": {
     "type": "Point",
     "coordinates": [
       10.716667,
       59.933333
     ]
   },
   "when": {
     "interval": [
       "2022-12-17T23:17:00Z",
       "2022-12-18T23:17:00Z"
     ]
   },
   "properties": {
     "body": "Moon",
     "moonrise": {
       "time": "2022-12-18T02:01+01:00",
       "azimuth": 98.49
     },
     "moonset": {
       "time": "2022-12-18T13:01+01:00",
       "azimuth": 255.99
     },
     "high_moon": {
       "time": "2022-12-18T07:41+01:00",
       "disc_centre_elevation": 23.89,
       "visible": true
     },
     "low_moon": {
       "time": "2022-12-18T20:03+01:00",
       "disc_centre_elevation": -39.17,
       "visible": false
     },
     "moonphase": {
       "value": 288.54
     }
   }
 }
 
 MOON PHASES
 Degrees        Descripton
 0              New moon
 0..90          Waxing crescent   Voksende halvmåne
 90..180        Waxing gibbous    Voksende gibbous
 180            Full moon
 180..270       Waning gibbous    Avtagende gibbous
 270..360       Waning crescent   Avtagende halvmåne

 https://www.timeanddate.no/astronomi/maanen/nymaane
 
 */
