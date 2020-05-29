import Foundation
import RxSwift

struct AndroidSpartanDetailsPresenter {
    private let disposeBag = DisposeBag()
    private let model: AndroidSpartansModel
    private let view: SpartanDetailsView
    private let serviceNumber: String

    init(model: AndroidSpartansModel = AndroidSpartansModel(), view: SpartanDetailsView, serviceNumber: String) {
        self.model = model
        self.view = view
        self.serviceNumber = serviceNumber

        loadSpartan()
    }

    private func loadSpartan() {
        model.androidFetchSpartan(serviceNumber: serviceNumber)
            .subscribe(onNext: { [weak view] spartan in
                view?.showBasicInfo(name: spartan.name, rank: spartan.rank.rawValue.capitalized, image: spartan.imageName)
                view?.showDetailInfo(height: "\(spartan.height) cm", weight: "\(spartan.weight) kg", homeworld: spartan.homeworld)

            }, onError: { error in
                //handle error
                print("Error")
            }).disposed(by: disposeBag)
    }
}
