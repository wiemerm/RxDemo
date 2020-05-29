import UIKit
import RxSwift
import RxCocoa

class SelectionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let selectionView = SelectionView()

    init() {
        super.init(nibName: nil, bundle: nil)

        selectionView.androidObservable
            .subscribe(onNext: openAndroidVersion)
            .disposed(by: disposeBag)

        selectionView.iOSObservable
            .subscribe(onNext: openIOSVersion)
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = selectionView
    }

    private func openAndroidVersion() {
        open(AndroidSpartansViewController())
    }

    private func openIOSVersion() {
        open(IOSSpartansViewController())
    }

    private func open(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

class SelectionView: UIView {
    let androidObservable: Observable<Void>
    let iOSObservable: Observable<Void>

    private let androidButton = UIButton()
    private let iOSButton = UIButton()

    init() {
        androidObservable = androidButton.rx.tap.asObservable()
        iOSObservable = iOSButton.rx.tap.asObservable()

        super.init(frame: .zero)
        backgroundColor = .white

        androidButton.setTitle("ANDROID", for: .normal)
        androidButton.setTitleColor(.blue, for: .normal)
        iOSButton.setTitle("iOS", for: .normal)
        iOSButton.setTitleColor(.blue, for: .normal)

        let containerView = UIView()

        containerView.addSubview(androidButton)
        containerView.addSubview(iOSButton)
        addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerInView(self)

        androidButton.translatesAutoresizingMaskIntoConstraints = false
        androidButton.constrainToSidesOfView(containerView)
        androidButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        iOSButton.translatesAutoresizingMaskIntoConstraints = false
        iOSButton.constrainToSidesOfView(containerView)
        iOSButton.topAnchor.constraint(equalTo: androidButton.bottomAnchor, constant: 16).isActive = true
        iOSButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
