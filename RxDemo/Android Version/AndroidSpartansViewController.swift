import UIKit
import RxSwift

class AndroidSpartansViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let spartansView: SpartansView
    private let presenter: AndroidSpartansPresenter

    init(spartansView: SpartansView = SpartansView()) {
        self.spartansView = spartansView
        presenter = AndroidSpartansPresenter(view: spartansView)

        super.init(nibName: nil, bundle: nil)

        spartansView.retryObservable
            .subscribe(onNext: presenter.refresh)
            .disposed(by: disposeBag)

        spartansView.dismissObservable
        .subscribe(onNext: { [weak self] in self?.dismiss(animated: true) })
            .disposed(by: disposeBag)

        spartansView.spartanObservable?
            .subscribe(onNext: { [weak self] in
                self?.open(spartan: $0.serviceNumber)
            })
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = spartansView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func open(spartan serviceNumber: String) {
        let spartanDetails = SpartanDetailsViewController(serviceNumber: serviceNumber)

        navigationController?.pushViewController(spartanDetails, animated: true)
    }
}
