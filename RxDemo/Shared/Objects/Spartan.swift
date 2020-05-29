import Foundation

struct Spartan {
    let serviceNumber: String
    let name: String
    let birth: String
    let death: String
    let height: Int
    let weight: Int
    let hairColor: String
    let eyeColor: String
    let rank: Rank
    let homeworld: String
    let armor: ArmorVariant
    var imageName: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "_")
    }
}

enum Rank: String {
    case commander
    case lieutenantCommander = "Lieutenant Commander"
    case lieutenant
    case warrantOfficer = "Warrant Officer"
    case chiefWarrantOfficer = "Chief Warrant Officer"
}

enum ArmorVariant: String {
    case commando
    case airAssault = "Air Assault"
    case scout
    case assault
    case grenadier
    case mkV
}
