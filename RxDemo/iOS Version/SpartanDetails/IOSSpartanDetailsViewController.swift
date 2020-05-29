import UIKit
import RxSwift

class IOSSpartanDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let spartanDetailsView: SpartanDetailsView
    private let model: IOSSpartansModel
    private let presenter: IOSSpartanDetailsPresenter

    private let serviceNumber: String

    init(spartanView: SpartanDetailsView = SpartanDetailsView(), model: IOSSpartansModel = IOSSpartansModel(), serviceNumber: String) {
        self.serviceNumber = serviceNumber
        self.spartanDetailsView = spartanView
        self.model = model
        presenter = IOSSpartanDetailsPresenter(model: model, view: spartanDetailsView)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = spartanDetailsView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSpartan()
    }

    private func fetchSpartan() {
//        model.spartanObserver.onNext(serviceNumber)
        model.fetchSpartan(serviceNumber: serviceNumber)
    }
}
