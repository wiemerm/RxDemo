import Foundation
import RxSwift

typealias SpartansResult = Result<[Spartan], NetworkError>
typealias SpartanResult = Result<Spartan, NetworkError>

protocol IOSSpartansModelInterface {
    //Both iOS Versions
    var spartansListObservable: Observable<SpartansResult> { get }
    var spartanObservable: Observable<SpartanResult> { get }

    //iOS Option 1
    var spartansListObserver: AnyObserver<Void> { get }
    var spartanObserver: AnyObserver<String> { get }

    //iOS Option 2
    func fetchNobleTeam()
    func fetchSpartan(serviceNumber: String)
}

struct IOSSpartansModel: IOSSpartansModelInterface {
    let spartansListObservable: Observable<SpartansResult>
    let spartansListObserver: AnyObserver<Void>

    let spartanObservable: Observable<SpartanResult>
    let spartanObserver: AnyObserver<String>

    private let spartansListSubject = PublishSubject<Void>()
    private let spartanSubject = BehaviorSubject<String>(value: "")

    init(service: SpartansService = SpartansService()) {
        //newer iOS
        spartansListObserver = spartansListSubject.asObserver()
        spartanObserver = spartanSubject.asObserver()

        //Both
        spartansListObservable = spartansListSubject
            .flatMapLatest { fetchSpartansSafely(service: service) }
            .asObservable()
            .share()

        spartanObservable = spartanSubject
            .flatMapLatest { fetchSpartanSafely(service: service, serviceNumber: $0)}
            .asObservable()
            .share()
    }

    //older iOS
    func fetchNobleTeam() {
        spartansListSubject.onNext(())
    }

    func fetchSpartan(serviceNumber: String) {
        spartanSubject.onNext(serviceNumber)
    }
}

private func fetchSpartansSafely(service: SpartansService) -> Single<SpartansResult> {
    service.fetchSpartans()
        .map { SpartansResult.success($0) }
        .catchError { _ in
            return Single.just(SpartansResult
                .failure(NetworkError(code: 500)))
    }
}

private func fetchSpartanSafely(service: SpartansService, serviceNumber: String) -> Single<SpartanResult> {
    return service.fetchSpartan(serviceNumber: serviceNumber)
        .map { SpartanResult.success($0) }
        .catchError { error in
            return Single.just(SpartanResult.failure(error as? NetworkError ?? NetworkError(code: 500)))
    }
}
