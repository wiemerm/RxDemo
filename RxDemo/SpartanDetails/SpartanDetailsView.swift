import UIKit
import RxSwift
import RxCocoa

class SpartanDetailsView: UIView {
    let dismissObservable: Observable<Void>

    private let dismissButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    init() {
        dismissObservable = dismissButton.rx.tap.asObservable()

        super.init(frame: .zero)
        backgroundColor = .red

        addSubview(dismissButton)

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
