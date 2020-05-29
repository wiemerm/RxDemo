import UIKit
import RxSwift
import RxCocoa

class SpartanDetailsView: UIView {
    private let avatarImageView = UIImageView()
    private let serviceNumberLabel = UILabel()
    private let nameLabel = TitleLabelView(title: "Name")
    private let rankLabel = TitleLabelView(title: "Rank")
    private let heightLabel = TitleLabelView(title: "Height")
    private let weightLabel = TitleLabelView(title: "Weight")
    private let homeworldLabel = TitleLabelView(title: "Homeworld")

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        let heightWeightView = UIStackView(arrangedSubviews: [heightLabel, weightLabel])
        heightWeightView.axis = .horizontal
        heightWeightView.spacing = 8

        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(rankLabel)
        addSubview(homeworldLabel)
        addSubview(heightWeightView)

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: verticalPadding).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
        avatarImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -horizontalPadding).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: verticalPadding).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
        nameLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -horizontalPadding).isActive = true

        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        rankLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
        rankLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -horizontalPadding).isActive = true

        homeworldLabel.translatesAutoresizingMaskIntoConstraints = false
        homeworldLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 4).isActive = true
        homeworldLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
        homeworldLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -horizontalPadding).isActive = true

        heightWeightView.translatesAutoresizingMaskIntoConstraints = false
        heightWeightView.topAnchor.constraint(equalTo: homeworldLabel.bottomAnchor, constant: 4).isActive = true
        heightWeightView.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalPadding).isActive = true
        heightWeightView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -horizontalPadding).isActive = true


        avatarImageView.isHidden = true
        nameLabel.isHidden = true
        rankLabel.isHidden = true
        homeworldLabel.isHidden = true
        heightLabel.isHidden = true
        weightLabel.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: iOS Update
    func update(_ spartan: Spartan) {
        avatarImageView.image = UIImage(named: spartan.imageName)
        nameLabel.text = spartan.name
        rankLabel.text = spartan.rank.rawValue.capitalized
        heightLabel.text = "\(spartan.height)"
        weightLabel.text = "\(spartan.weight)"
        homeworldLabel.text = spartan.homeworld

        avatarImageView.isHidden = false
        nameLabel.isHidden = false
        rankLabel.isHidden = false
        homeworldLabel.isHidden = false
        heightLabel.isHidden = false
        weightLabel.isHidden = false
    }

    //MARK: Android Update
    func showBasicInfo(name: String, rank: String, image: String) {
        nameLabel.text = name
        rankLabel.text = rank
        avatarImageView.image = UIImage(named: image)

        avatarImageView.isHidden = false
        nameLabel.isHidden = false
        rankLabel.isHidden = false
    }

    func showDetailInfo(height: String, weight: String, homeworld: String) {
        heightLabel.text = height
        weightLabel.text = weight
        homeworldLabel.text = homeworld

        homeworldLabel.isHidden = false
        heightLabel.isHidden = false
        weightLabel.isHidden = false
    }
}
