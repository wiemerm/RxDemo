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
        // Later versions used Observers which get called with .onNext to trigger Subject to fetch the data
        spartansListObserver = spartansListSubject.asObserver()
        spartanObserver = spartanSubject.asObserver()

        //Set up observables to watch subject and call to service
        spartansListObservable = spartansListSubject
            .flatMapLatest { fetchSpartansSafely(service: service) }
            .asObservable()
            .share()

        spartanObservable = spartanSubject
            .flatMapLatest { fetchSpartanSafely(service: service, serviceNumber: $0)}
            .asObservable()
            .share()
    }

    //Alternatively earlier code used observable tied to subject with a function that would trigget the subject onNext
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

/*
 iOS:
 The course that iOS chose was to attempt to fetch the data and catch any errors that occur mapping the error to a failed result instead of going through onError of the observable.
 Using result type and the fetch{item}Safely functions mean that if an error does occur, the Observable will not return the onError followed by onCompleted and will instead return an error within the onNext block and not close the observable allowing it to be disposed.

 Android:
 Model calls that service and ensures that the resulting observable is on the main thread for the presenter. Some mapping or filtering may occur within the model if needed (ex. Explore tab maps the categories to add the "Explore the ATC" item to the list

 Android primarily uses Observable instead of iOS which uses Single in the service layer and converts to Observable in the model layer

 Personal preference: Android - easier to test and less complicated
 */
