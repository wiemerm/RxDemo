import UIKit

class TitleLabelView: UIStackView {
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    private let titleLabel = UILabel()
    private let textLabel = UILabel()

    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = "\(title):"

        addArrangedSubview(titleLabel)
        addArrangedSubview(textLabel)

        axis = .horizontal
        spacing = 4
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
