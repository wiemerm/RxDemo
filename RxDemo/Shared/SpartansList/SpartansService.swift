import Foundation
import RxSwift

class SpartansService {
    private var firstLaunch = true //fake out error first time loading the list

    func fetchSpartans() -> Single<[Spartan]> {
        let response = firstLaunch ? Single.error(NetworkError(code: 500)) : Single.just(SpartansHelper.nobleTeam())

        firstLaunch = false
        return response
    }

    func fetchSpartan(serviceNumber: String) -> Single<Spartan> {
        guard let spartan = SpartansHelper.nobleTeam().first(where: { $0.serviceNumber == serviceNumber }) else {
            return Single.error(NetworkError(code: 404))
        }

        return Single.just(spartan)
    }
}
