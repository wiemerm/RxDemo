import Foundation
import RxSwift

struct AndroidSpartansModel {
    private let service: SpartansService

    init(service: SpartansService = SpartansService()) {
        self.service = service
    }

    func androidFetchNobleTeam() -> Observable<[Spartan]> {
        return service.fetchSpartans()
            .observeOn(MainScheduler.instance)
            .asObservable()
    }

    func androidFetchSpartan(serviceNumber: String) -> Observable<Spartan> {
        return service.fetchSpartan(serviceNumber: serviceNumber)
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
}
