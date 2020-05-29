import Foundation

struct SpartansHelper {
    static let carter = Spartan(serviceNumber: "S-A259",
                                name: "Carter", birth: "August 27, 2520", death: "August 30, 2552",
                                height: 208, weight: 113, hairColor: "Black", eyeColor: "Blue",
                                rank: .commander, homeworld: "Biko", armor: .commando)

    static let kat = Spartan(serviceNumber: "S-B320",
                             name: "Kat", birth: "January 30, 2530", death: "August 23, 2552",
                             height: 205, weight: 111, hairColor: "black", eyeColor: "blue",
                             rank: .lieutenantCommander, homeworld: "New Harmony", armor: .airAssault)

    static let jun = Spartan(serviceNumber: "S-A266",
                             name: "Jun", birth: "February 28, 2524", death: "N/A",
                             height: 210, weight: 111, hairColor: "bald", eyeColor: "blue",
                             rank: .warrantOfficer, homeworld: "New Harmony", armor: .scout)

    static let emile = Spartan(serviceNumber: "S-A239",
                               name: "Emile", birth: "March 11, 2523", death: "August 30, 2552",
                               height: 208, weight: 105, hairColor: "unknown", eyeColor: "unknown",
                               rank: .warrantOfficer, homeworld: "Eridanus II", armor: .assault)

    static let jorge = Spartan(serviceNumber: "S-052",
                               name: "Jorge", birth: "March 5, 2511", death: "August 14, 2552",
                               height: 223, weight: 145, hairColor: "brown", eyeColor: "brown",
                               rank: .chiefWarrantOfficer, homeworld: "Reach", armor: .grenadier)

    static let nobleSix = Spartan(serviceNumber: "S-B312",
                                  name: "Noble 6", birth: "Unknown", death: "August 30, 2552",
                                  height: 205, weight: 108, hairColor: "Unknown", eyeColor: "Unknown",
                                  rank: .lieutenant, homeworld: "Jericho VII", armor: .mkV)

    static func nobleTeam() -> [Spartan] {
        return [
            SpartansHelper.carter,
            SpartansHelper.kat,
            SpartansHelper.jun,
            SpartansHelper.emile,
            SpartansHelper.jorge,
            SpartansHelper.nobleSix
        ]
    }
}

struct NetworkError: Error {
    let code: Int
    var localizedDescription: String { return HTTPURLResponse.localizedString(forStatusCode: code)
    }
}

