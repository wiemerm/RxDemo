import Foundation
import RxSwift

struct AndroidSpartansModel {
    private let service: SpartansService

    init(service: SpartansService = SpartansService()) {
        self.service = service
    }

    //Replicate what Android does for fetching and observables
    func androidFetchNobleTeam() -> Observable<[Spartan]> {
        return service.fetchSpartans()
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
}