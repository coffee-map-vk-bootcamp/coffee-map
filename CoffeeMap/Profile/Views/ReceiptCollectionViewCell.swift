//
//  ReceiptCollectionViewCell.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//

import UIKit

final class ReceiptCollectionViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.textColor = .primaryTextColor
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .primaryTextColor
        label.textAlignment = .left
        return label
    }()

    private let orderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()

    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать полностью", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.isHidden = true
        return button
    }()

    private var stackBottomConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        selectionStyle = .none

        let background = UIView()
        background.backgroundColor = .secondaryBackground
        background.layer.cornerRadius = 12

        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        let backgroundConstraints = [
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]

        background.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: background.trailingAnchor, constant: -20)
        ]

        background.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: background.trailingAnchor, constant: -20)
        ]

        background.addSubview(orderStack)
        orderStack.translatesAutoresizingMaskIntoConstraints = false
        let stackConstraints = [
            orderStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            orderStack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            orderStack.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20)
        ]
        stackBottomConstraint = NSLayoutConstraint(item: orderStack,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: background,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: -20)
        stackBottomConstraint?.isActive = true

        background.addSubview(detailButton)
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonConstraints = [
            detailButton.topAnchor.constraint(equalTo: orderStack.bottomAnchor, constant: 12),
            detailButton.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            detailButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -20)
        ]

        NSLayoutConstraint.activate(backgroundConstraints +
                                    titleConstraints +
                                    dateConstraints +
                                    stackConstraints +
                                    buttonConstraints)
    }

    private func makeDishView(with model: OrderDish) -> UIView {
        let view = UIView()
        view.backgroundColor = .secondaryBackground

        let nameLabel = UILabel()
        nameLabel.textColor = .primaryTextColor
        nameLabel.backgroundColor = .secondaryBackground
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        let priceLabel = UILabel()
        priceLabel.textColor = .primaryTextColor
        priceLabel.textAlignment = .right
        priceLabel.backgroundColor = .secondaryBackground
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let countLabel = UILabel()
        countLabel.textColor = .primaryTextColor
        countLabel.textAlignment = .left
        countLabel.backgroundColor = .secondaryBackground
        countLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)

        nameLabel.text = model.name
        priceLabel.text = "\(model.price) ₽"
        countLabel.text = "В количестве: \(model.count)"

        view.addSubviews([nameLabel, priceLabel, countLabel])
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameConstraints = [
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ]

        let priceConstraints = [
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ]

        let countConstraints = [
            countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(nameConstraints + priceConstraints + countConstraints)

        return view
    }

    func configure(with order: ReceiptCellModel) {
        titleLabel.text = "Заказ из " + order.name
        
        dateLabel.text = "От: " + order.date.description

//        detailButton.isHidden = !(order.dishes.count > 3)
//        stackBottomConstraint?.isActive = detailButton.isHidden

        orderStack.subviews.forEach {
            orderStack.removeArrangedSubview($0)
        }
        order.dishes.forEach {
            orderStack.addArrangedSubview(makeDishView(with: $0))
        }
    }
}
