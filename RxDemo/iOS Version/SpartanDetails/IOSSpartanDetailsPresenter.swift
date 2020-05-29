import Foundation
import RxSwift

struct IOSSpartanDetailsPresenter {
    private let disposeBag = DisposeBag()

    init(model: IOSSpartansModelInterface, view: SpartanDetailsView) {
        model.spartanObservable
            .subscribe(onNext: { result in
                guard let spartan = try? result.get() else { return }

                view.update(spartan)
            })
            .disposed(by: disposeBag)

        model.spartanObservable
            .filter { (try? $0.get()) == nil }
            .subscribe({ _ in
                //handle the error
            })
        .disposed(by: disposeBag)
    }
}
