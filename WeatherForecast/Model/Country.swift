import Foundation

// MARK: - CountryInfoElement
struct CountryInfoElement: Codable {
    let name: Name
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
//    let nativeName: [String: NativeName]
}

// MARK: - NativeName
//struct NativeName: Codable {
//    let official, common: String
//}

typealias CountryInfo = [CountryInfoElement]

