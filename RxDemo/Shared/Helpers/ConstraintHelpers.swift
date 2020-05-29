import UIKit

extension UIView {
    func constrainToEdgesOfView(_ view: UIView, padding: CGFloat = 0) {
        constrainToTopOfView(view, padding: padding)
        constrainToBottomOfView(view, padding: padding)
        constrainToSidesOfView(view, padding: padding)
    }

    func constrainToSidesOfView(_ view: UIView, padding: CGFloat = 0) {
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
    }

    func constrainToTopOfView(_ view: UIView, padding: CGFloat = 0) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
    }

    func constrainToBottomOfView(_ view: UIView, padding: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
    }

    func centerInView(_ view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UILabel {
    func title() {
        font = font.withSize(20)
        textColor = .darkText
    }

    func subTitle() {
        font = font.withSize(16)
        textColor = .gray
    }
}
