import UIKit
import RxSwift

class AndroidSpartanDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let spartanDetailsView = SpartanDetailsView()
    private let presenter: AndroidSpartanDetailsPresenter

    init(serviceNumber: String, model: AndroidSpartansModel = AndroidSpartansModel()) {
        presenter = AndroidSpartanDetailsPresenter(model: model, view: spartanDetailsView, serviceNumber: serviceNumber)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = spartanDetailsView
    }
}
