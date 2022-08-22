//
//  ProfileTableViewHeader.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//

import UIKit

final class ProfileTableViewHeader: UITableViewHeaderFooterView {
    
    weak var output: ProfileHeaderOutput?

    private let avatarImage: SkeletonImageView = {
        let imageView = SkeletonImageView()
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Загрузка..."
        return label
    }()

    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: AppImageNames.exit)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        let avatarImageConstraints = [
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ]

        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: exitButton.leadingAnchor, constant: -12)
        ]
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        let closeButtonConstraints = [
            exitButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            exitButton.widthAnchor.constraint(equalToConstant: 24),
            exitButton.heightAnchor.constraint(equalToConstant: 24)
        ]

        NSLayoutConstraint.activate(avatarImageConstraints + nameLabelConstraints + closeButtonConstraints)
    }

    func configure(with model: User) {
        avatarImage.setImage(with: model.image)
        nameLabel.text = model.name
    }
    
    @objc
    private func logout() {
        output?.logout()
    }
}
