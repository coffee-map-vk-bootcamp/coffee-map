//
//  ProfileCollectionViewHeader.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//

import UIKit

final class ProfileCollectionViewHeader: UICollectionReusableView {

    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: AppImageNames.exit), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            avatarImage.widthAnchor.constraint(equalToConstant: 70)
        ]

        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -24)
        ]
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let closeButtonConstraints = [
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ]

        NSLayoutConstraint.activate(avatarImageConstraints + nameLabelConstraints + closeButtonConstraints)
    }

    func configure() {
        
    }
}
