import UIKit
import RxSwift

class IOSSpartansViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let spartansView: SpartansView
    private let model: IOSSpartansModelInterface
    private let presenter: iOSSpartansPresenter

    init(spartansView: SpartansView = SpartansView(), model: IOSSpartansModelInterface = IOSSpartansModel()) {
        self.model = model
        self.spartansView = spartansView
        presenter = iOSSpartansPresenter(model: model, view: spartansView)

        super.init(nibName: nil, bundle: nil)

        spartansView.retryObservable
            .subscribe(onNext: { [weak self] in self?.fetchNobleTeam() })
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
        fetchNobleTeam()
    }

    private func fetchNobleTeam() {
        model.spartansListObserver.onNext(()) //newer iOS
//        model.fetchNobleTeam() //earlier iOS
    }

    private func open(spartan serviceNumber: String) {
        let spartanDetails = SpartanDetailsViewController(serviceNumber: serviceNumber)

        navigationController?.pushViewController(spartanDetails, animated: true)
    }

}
