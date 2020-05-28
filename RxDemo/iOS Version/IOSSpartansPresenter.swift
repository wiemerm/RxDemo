import Foundation
import RxSwift

//iOS Method
struct iOSSpartansPresenter {
    private let disposeBag = DisposeBag()

    init(model: IOSSpartansModelInterface, view: SpartansView) {

        model.spartansListObservable
            .compactMap { try? $0.get() }
            .subscribe(onNext: { spartans in
                view.update(spartans)
            })
            .disposed(by: disposeBag)

        model.spartansListObservable
            .filter { result in
                switch result {
                case .success: return false
                case .failure: return true
                }
            }
            .subscribe({ event in
                view.handleError()
            })
            .disposed(by: disposeBag)
    }
}

// iOS uses helper methods from RxSugar such as ignoreNil
