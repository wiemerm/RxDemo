import UIKit
import RxSwift

class SpartanDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let spartanDetailsView = SpartanDetailsView()

    init(serviceNumber: String) {
        super.init(nibName: nil, bundle: nil)

        spartanDetailsView.dismissObservable
            .subscribe(onNext: dismiss)
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = spartanDetailsView
    }

    private func dismiss() {
        dismiss(animated: true)
    }
}
