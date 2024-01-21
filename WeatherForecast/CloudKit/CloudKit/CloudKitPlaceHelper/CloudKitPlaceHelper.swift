//
//  CloudKitPlaceHelper.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/01/2023.
//

import SwiftUI
import CloudKit
import WeatherKit

///
/// Ved å endre f. eks. func save(person: Person)  til:
///     func save(_ person: Person)  kan den kalles slik:
///     save(person) i stedet for save(person: person)
///

///
/// @MainActor
/// var teller: Int = 0
///
/// func incrementCounter() {
///      teller = 1
/// }
///
/// I dette eksemplet er tellervariabelen kommentert med @MainActor,
/// noe som betyr at den kun kan åpnes og endres fra hovedtråden.
/// IncrementCounter-funksjonen kan kalles fra hvilken som helst tråd,
/// men den vil alltid bli utført på hovedtråden, takket være
/// @MainActor-kommentaren på tellervariabelen.
///
/// Totalt sett er @MainActor et kraftig verktøy for å administrere
/// samtidighet i SwiftUI-apper, siden det bidrar til å sikre at
/// UI-oppdateringer utføres trygt og effektivt på hovedtråden.
///

@MainActor
func ModPlace(_ place: Place) async -> (status: Bool, message: LocalizedStringKey) {
    var status: Bool = false
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitPlace().ModifyPlace(place)
        message = "The place record has been modified in CloudKit"
        status = true
        return (status, message)
    } catch {
        message = LocalizedStringKey(error.localizedDescription)
        status = false
        return (status, message)
    }
}

@MainActor
func SavePlace(_ place: Place) async -> (status: Bool, err: LocalizedStringKey, message: LocalizedStringKey)      {
    var err : LocalizedStringKey = ""
    var message: LocalizedStringKey = ""
    var status : Bool = false
    do {
        try await CloudKitPlace().SavePlace(place)
        message = "'\(place.place)' has been saved in CloudKit."
        status = true
    } catch {
        status = false
        err = LocalizedStringKey(error.localizedDescription)
        message = "Error '\(place.place)'"
    }
    return (status, err, message)
}

@MainActor
func ExistPlace(_ place: Place) async -> (exist: Bool, err: LocalizedStringKey, message:LocalizedStringKey) {
    var err : LocalizedStringKey = ""
    var message : LocalizedStringKey = ""
    var exist : Bool = false
    do {
        exist = try await CloudKitPlace.ExistPlace(place)
        err = ""
        if exist == true {
            message = "\n'\(place.place)' exist in CloudKit"
        } else {
            message = "\n'\(place.place)' does not exist in CloudKit"
        }
    } catch {
        err  = LocalizedStringKey(error.localizedDescription)
        exist = false
    }
    return (exist, err, message)
}

@MainActor
func PlaceRecordId(_ place: Place) async -> (status: Bool, err: LocalizedStringKey, message: LocalizedStringKey, id: CKRecord.ID?) {
    var status: Bool
    var err : LocalizedStringKey = ""
    var id: CKRecord.ID?
    var message: LocalizedStringKey = ""
    do {
        id = try await CloudKitPlace().PlaceRecordID(place)
        if id != nil {
            status = true
            err = ""
            message = "CKRecord.ID is found"
        } else {
            id = nil
            status = false
            err = ""
            message = "CKRecord.ID is nil"
        }
    } catch {
        id = nil
        status = false
        err = LocalizedStringKey(error.localizedDescription)
        message = "Error find CKRecord.ID"
    }
    return (status, err, message, id)
}

@MainActor
func DeletePlace(_ recID: CKRecord.ID) async -> (status: Bool, err: LocalizedStringKey, message: LocalizedStringKey) {
    var status: Bool = false
    var err: LocalizedStringKey = ""
    var message: LocalizedStringKey = ""
    do {
        try await CloudKitPlace.DeletePlace(recID)
        message = "The place has been deleted"
        status = true
    } catch {
        err = LocalizedStringKey(error.localizedDescription)
        message = "Error find CKRecord.ID "
    }
    return (status, err, message)
}

@MainActor
func FindPlaces() async -> (status: Bool, place: [Place], err: LocalizedStringKey, message: LocalizedStringKey) {
    var status: Bool = false
    var places = [Place]()
    var err: LocalizedStringKey = ""
    var message: LocalizedStringKey = ""
    do {
        places = try await CloudKitPlace().FindPlaces()
        status = true
        err = ""
        if places.count > 0 {
            message = "Received all places."
        } else {
            message = "No places to be found in CloudKit."
        }
    } catch {
        places = [Place]()
        err  = LocalizedStringKey(error.localizedDescription)
        status = false
        message = "Error fetching places."
    }
    ///
    /// Sorterer stedene:
    ///
    places.sort(by: {$0.place < $1.place})
    return (status, places, err, message)
}

@MainActor
func FindAllPlaces() async -> (status: Bool, places: [Place], title: LocalizedStringKey, message: LocalizedStringKey) {
    var status: Bool = false
    var places = [Place]()
    var title: LocalizedStringKey = ""
    var message: LocalizedStringKey = ""
    var value: (Bool, [Place], LocalizedStringKey, LocalizedStringKey )
    await value = FindPlaces()
    
    if value.0 == false {
        ///
        /// Feilmelding:
        ///
        status = false
        message = value.2
        title = "Error message from CloudKit"
    } else {
        ///
        /// OK:
        ///
        status = true
        message = value.3
        title = "Found all places"
        places = value.1
        
    }
    return (status, places, title, message)
}

@MainActor
func DeleteOnePlace(_ place: Place) async -> (status: Bool, message: LocalizedStringKey) {
    
    var status: Bool = false
    var message: LocalizedStringKey = ""
    var id: CKRecord.ID?
    ///
    /// For å kunne slette et sted må stedet finnes i CloudKit:
    ///
    var value : (Bool, LocalizedStringKey, LocalizedStringKey)
    await value = ExistPlace(place)
    if value.1 == "" {
        ///
        /// Ingen feilmelding:
        ///
        if value.0 == true {
            ///
            /// Stedet finnes i CloudKit og da må: CKRecord.ID finnes
            ///
            var value1: (Bool, LocalizedStringKey, LocalizedStringKey, CKRecord.ID?)
            await value1 = PlaceRecordId(place)
            if value1.0 == true {
                ///
                /// Fant CKRecord.ID:
                ///
                id = value1.3
                ///
                /// Nå kan stedet slettes:
                ///
                var value3 : (Bool, LocalizedStringKey, LocalizedStringKey)
                await value3 = DeletePlace(id!)
                
                if value3.0 == true {
                    ///
                    /// Stedet er nå slettet
                    ///
                    status = true
                    ///
                    /// Overstyrer value3.2: "The place has been deleted"
                    ///
                    message = "'\(place.place)' has been deleted."
                }
            }
        } else {
            status = false
            message = "'\(place.place)' does not exist in CloudKit."
        }
    } else {
        ///
        /// Feilmelding:
        ///
        status = false
        message = value.1
    }
    return (status, message)
}

@MainActor
func SaveNewPlace(_ place: Place) async -> (status: Bool, message: LocalizedStringKey) {
    
    var status: Bool = false
    var message: LocalizedStringKey = ""
    ///
    /// For å kunne lagre et sted må det sjekkes om stedet finnes fra før i CloudKit:
    ///
    var value : (Bool, LocalizedStringKey, LocalizedStringKey)
    await value = ExistPlace(place)
    if value.1 == "" {
        ///
        /// Ingen feilmelding:
        /// Sjekk om stedet finnes fra før:
        ///
        if value.0 == true {
            ///
            /// Stedet finnes fra før:
            ///
            status = false
            message = value.2
        } else {
            ///
            /// Stedet finnes ikke fra før:
            ///
            var value1 : (Bool, LocalizedStringKey,LocalizedStringKey)
            await value1 = SavePlace(place)
            if value1.0 == true {
                ///
                /// Stedet er lagret:
                ///
                status = true
                message = value1.2
            } else {
                ///
                /// Stedet ble ikke lagret på grunn av en feil:
                ///
                status = false
                message = value1.1
            }
        }
    } else {
        ///
        /// Feilmelding:
        ///
        status = false
        message = value.1
    }
    return (status, message)
}

@MainActor
func RefreshAllPlaces(refreshWeather: Bool) async -> (message: LocalizedStringKey, [Place]) {
    ///
    /// Henter alle stedene som ligger i CloudKit:
    ///
    var places: [Place] = []
    let weatherService = WeatherService.shared
    var weather : Weather?
    var message: LocalizedStringKey = ""
    let value: (Bool, [Place], LocalizedStringKey, LocalizedStringKey)
    await value = FindAllPlaces()
    if value.0 == true {
        places = value.1
     } else {
        places.removeAll()
    }
    if refreshWeather == true {
        let count = places.count
        for i in 0..<count {
            ///
            /// Finn: temperature, lowTemperature, highTemperature og condition:
            ///
            let location = CLLocation(latitude: places[i].lat ?? 0.00, longitude: places[i].lon ?? 0.00)
            do {
                weather = try await weatherService.weather(for: location)
                if let weather {
                    places[i].temperature = weather.currentWeather.temperature.value
                    places[i].lowTemperature = weather.dailyForecast.forecast[0].lowTemperature.value
                    places[i].highTemperature =  weather.dailyForecast.forecast[0].highTemperature.value
                    places[i].condition = weather.currentWeather.condition.description
                    places[i].isDaylight = weather.currentWeather.isDaylight
                }
            } catch {
                message = LocalizedStringKey(error.localizedDescription)
                debugPrint(error)
            }
        }
    }
    return (message, places)
}


