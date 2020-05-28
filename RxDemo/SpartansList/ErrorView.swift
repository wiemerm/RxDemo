import UIKit
import RxSwift
import RxCocoa

class ErrorView: UIView {
    let retryObservable: Observable<Void>
    private let retryButton = UIButton()

    init() {
        retryObservable = retryButton.rx.tap.asObservable()

        super.init(frame: .zero)

        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.blue, for: .normal)

        addSubview(retryButton)

        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retryButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
