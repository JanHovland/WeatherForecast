//
//  RefreshOffset.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 12/03/2023.
//

import SwiftUI
import CloudKit
import WeatherKit

func RefreshOffset() async -> (status: Bool, message: LocalizedStringKey) {
    ///
    /// Denne funksjonen benyttes dersom det trengs modifisering når sommertiden kommer:
    ///
    var status: Bool = false
    var message: LocalizedStringKey = ""
    var places: [Place] = []
    var counter: Int = 0
    ///
    /// Finner alle stedene i Place tabellen i CloudKit:
    ///
    places.removeAll()
    let value: (Bool, [Place], LocalizedStringKey, LocalizedStringKey)
    await value = FindAllPlaces()
    if value.0 == true {
        places = value.1
     } else {
        places.removeAll()
    }
    ///
    /// Oppdaterer offsetSec og offsetString for eventuell overgang til sommertid:
    ///
    let count = places.count
    if count == 0 {
        message = "Did not find any places."
        return (status, message)
    }
    let key = UserDefaults.standard.object(forKey: "KeyOpenCage") as? String ?? ""
    let urlOpenCage = UserDefaults.standard.object(forKey: "UrlOpenCage") as? String ?? ""
    ///
    /// Går gjennom alle stedene og sjekker og og modifiserer offsetSec og offsetString:
    ///
    for i in 0..<count {
        var geoRecord = GeoRecord()
        ///
        /// Hente geoRecord for place sin breddegrad og lengdegrad:
        ///
        geoRecord = await GetReverseGeoCode(latitude: places[i].lat!,
                                            longitude: places[i].lon!,
                                            key: key,
                                            urlOpenCage: urlOpenCage)
        ///
        /// Lagre den nye posten:
        ///
        let item = Place(recordID: places[i].recordID,
                         place: places[i].place,
                         flag: places[i].flag,
                         country: places[i].country,
                         lon: places[i].lon,
                         lat: places[i].lat,
                         offsetSec: geoRecord.offsetSec,
                         offsetString: geoRecord.offsetString,
                         dst: geoRecord.dst,
                         zoneName: geoRecord.zoneName,
                         zoneShortName: geoRecord.zoneShortName)
        
        let value: (Bool, LocalizedStringKey)
        ///
        /// Modifiserer place:
        ///
        value = await ModPlace(item)
        if value.0 == true {
            counter = counter + 1
            ///
            /// Stedet er modifisert
            ///
        } else {
            ///
            /// Stedet ble ikke modifisert !!!
            ///
        }
    }
    if counter == count {
        status = true
        message = "All places is now modified."
    } else {
        status = false
        message = "Error with the modification of the places."

    }
    return (status, message)
}
