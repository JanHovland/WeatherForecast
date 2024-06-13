//
//  GeoRecord.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 28/09/2022.
//

import Foundation

struct GeoRecord: Identifiable, Hashable  {
    var id = UUID()
    var searchString: String = ""   // Varhaug
    var latitude : Double?          // latitude  = breddegrad
    var longitude : Double?         // longitude = lengdegrad
    var formatted = String()        // Uelandsgata 2, 4360 Varhaug, Norge
    ///
    /// Reverse geocoding:
    ///
    var category = String()
    var type = String()
    var continent = String()
    var country = String()          // Norge
    var flag = String()
    var countryCode = String()
    var county = String()           // Rogaland
    var municipality = String()
    var postalCity = String()       // Varhaug
    var postcode = String()         // 4360
    var village = String()          // Varhaug
    var hamlet = String()
    var neighbourhood = String()
    var city = String()
    var town = String()
    var state = String()
    
    var place = String()
    
    /// Timezone
     
    var timezone = String()
    
    ///
    /// *_*Eksempel :  Oslo
    ///
    
    var name = String()             //  "Europe/Oslo"
    var dst = Int()                 //   0 = ikke sommertid 1 = sommertid
    var offsetSec = Int()           //   3600 som er +1 time(r) i forhold til UTC
    var offsetString = String()     //  "+0100" som er +1 time(r) i forhold til UTC
    var zoneShortName = String()    //  "CET"  CET  = Central European Time
                                    //  "CEST" CEST = Central European Summer Time
    var zoneName = String()         //  "Europe/Oslo" 
                                 
}
