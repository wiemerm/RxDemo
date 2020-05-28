import UIKit

class SpartanTableViewCell: UITableViewCell, ReusableCell {
    private let verticalPadding: CGFloat = 8
    private let horizontalPadding: CGFloat = 16

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let rankLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.clipsToBounds = true

        nameLabel.title()
        rankLabel.subTitle()

        let containerView = UIView()

        contentView.addSubview(avatarImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(rankLabel)

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalPadding).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true

        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: verticalPadding).isActive = true
        rankLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        rankLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor).isActive = true
        rankLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: horizontalPadding).isActive = true
        containerView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -horizontalPadding).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ spartan: Spartan) {
        nameLabel.text = spartan.name
        rankLabel.text = spartan.rank.rawValue.capitalized
        avatarImageView.image = UIImage(named: spartan.imageName)
    }
}
