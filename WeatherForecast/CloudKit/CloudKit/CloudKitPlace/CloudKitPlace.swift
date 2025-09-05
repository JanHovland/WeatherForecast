//
//  CloudKitPlace.swift
//  WeatherForecast
//
//  Created by Jan Hovland on 13/01/2023.
//

import CloudKit
import SwiftUI

struct CloudKitPlace {

    struct RecordType {
        static let place = "Place"
    }
    
    func ModifyPlace(_ place: Place) async throws {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        guard let recID = place.recordID else { return }
        ///
        /// Finner ikke riktig recID for å slette posten, dermed vises både den nye og den gamle posten:
        ///
        do {
            let placeRecord = CKRecord(recordType: RecordType.place)
            placeRecord["place"] = place.place
            placeRecord["flag"] = place.flag
            let country = TranslateCountry(country: place.country)
            placeRecord["country"] = country
            placeRecord["lon"] = place.lon
            placeRecord["lat"] = place.lat
            placeRecord["offsetSec"] = place.offsetSec
            placeRecord["offsetString"] = place.offsetString
            placeRecord["dst"] = place.dst
            placeRecord["zoneName"] = place.zoneName
            placeRecord["zoneShortName"] = place.zoneShortName
            do {
                let _ = try await database.modifyRecords(saving: [placeRecord], deleting: [recID])
            } catch {
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func SavePlace(_ place: Place) async throws {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        let placeRecord = CKRecord(recordType: RecordType.place)
        placeRecord["place"] = place.place
        placeRecord["flag"] = place.flag
        let country = TranslateCountry(country: place.country)
        placeRecord["country"] = country
        placeRecord["lon"] = place.lon
        placeRecord["lat"] = place.lat
        placeRecord["offsetSec"] = place.offsetSec
        placeRecord["offsetString"] = place.offsetString
        placeRecord["dst"] = place.dst
        placeRecord["zoneName"] = place.zoneName
        placeRecord["zoneShortName"] = place.zoneShortName
        
        do {
            try await database.save(placeRecord)
        } catch {
            throw error
        }
    }
    
    static func ExistPlace(_ place: Place) async throws -> Bool {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        ///
        /// Bruk %lf ved Double:
        /// Bruk %i  ved Date sammen med  'as CVarArg'
        ///
        let predicate = NSPredicate(format: "place = %@", place.place)
        let query = CKQuery(recordType: RecordType.place, predicate: predicate)
        do {
            let result = try await database.records(matching: query)
            for _ in result.0 {
                return true
            }
        } catch {
            throw error
        }
        return false
     }
    
    
    static func DeletePlace(_ recID: CKRecord.ID) async throws {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        do {
            try await database.deleteRecord(withID: recID)
        } catch {
            throw error
        }
    }
    
    func PlaceRecordID(_ place: Place) async throws -> CKRecord.ID? {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        ///
        /// Bruk %lf ved Double:
        /// Bruk %i  ved Date sammen med  'as CVarArg'
        ///
        let predicate = NSPredicate(format: "place = %@", place.place)
        let query = CKQuery(recordType: RecordType.place, predicate: predicate)
        do {
            ///
            /// Siden database.records(matching: query) er brukt tidligere må CloudKitArticle settes inn foran database
            ///
            let result = try await database.records(matching: query)
            for res in result.0 {
                let id = res.0.recordName
                return CKRecord.ID(recordName: id)
            }
        } catch {
            throw error
        }
        return nil
    }

    func DeletePlace(_ recID: CKRecord.ID) async throws {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        do {
            try await database.deleteRecord(withID: recID)
        } catch {
            throw error
        }
    }

    func FindPlaces() async throws -> [Place] {
        let database = CKContainer(identifier: Config.containerIdentifier).privateCloudDatabase
        var places = [Place]()
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.place, predicate: predicate)
        do {
            ///
            /// Slik finnes alle stedene:
            ///
            let result = try await database.records(matching: query)
            
            for record in result .matchResults {
                var place = Place(place: "",
                                  lon: nil,
                                  lat: nil)
                ///
                /// Slik hentes de enkelte feltene ut:
                ///
                let plac  = try record.1.get()
                
                let id = record.0.recordName
                let recID = CKRecord.ID(recordName: id)
                
                let pla = plac.value(forKey: "place") ?? ""
                let lon = plac.value(forKey: "lon") ?? 0.00
                let lat = plac.value(forKey: "lat") ?? 0.00
                let flag = plac.value(forKey: "flag") ?? ""
                let country = plac.value(forKey: "country") ?? ""
                let offsetSec = plac.value(forKey: "offsetSec") ?? 0
                let offsetString = plac.value(forKey: "offsetString") ?? ""
                let dst = plac.value(forKey: "dst") ?? 0
                let zoneName = plac.value(forKey: "zoneName") ?? ""
                let zoneShortName = plac.value(forKey: "zoneShortName") ?? ""

                place.recordID = recID
                place.place = pla as! String
                place.lon = lon as? Double
                place.lat = lat as? Double
                place.flag = flag as! String
                place.country = country as! String
                place.offsetSec = offsetSec as! Int
                place.offsetString = offsetString as! String
                place.dst = dst as! Int
                place.zoneName = zoneName as! String
                place.zoneShortName = zoneShortName as! String

                places.append(place)
                places.sort(by: {$0.place < $1.place})
            }
            return places
        } catch {
            throw error
        }
    }
}
