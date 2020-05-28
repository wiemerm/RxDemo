import Foundation
import RxSwift

//Android Method
struct AndroidSpartansPresenter {
    private let disposeBag = DisposeBag()
    private let model: AndroidSpartansModel
    private let view: SpartansView

    init(model: AndroidSpartansModel = AndroidSpartansModel(), view: SpartansView) {
        self.model = model
        self.view = view

        loadSpartans(refresh: false)
    }

    func refresh() {
        loadSpartans(refresh: true)
    }

    private func loadSpartans(refresh: Bool) {
        model.androidFetchNobleTeam()
            .subscribe(onNext: { [weak view] spartans in
                view?.update(spartans)
            }, onError: { [weak view] error in
                view?.handle(error)
            })
            .disposed(by: disposeBag)
    }
}
