//
//  DishConfigurationAlertView.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 22.08.2022.
//

import UIKit

protocol DishConfigurationAlertViewDelegate: AnyObject {
    func didTapAddToCart(amount: Int, price: Int)
    func didTapClose()
}

final class DishConfigurationAlertView: UIView {
    weak var delegate: DishConfigurationAlertViewDelegate?
    
    private lazy var dishImageView = SkeletonImageView()
    
    private lazy var dishNameLabel = UILabel(text: "Название продукта",
                                             font: .systemFont(ofSize: 18, weight: .semibold),
                                             color: .primaryTextColor)
    private lazy var priceLabel = UILabel(text: "0,0 ₽",
                                          font: .systemFont(ofSize: 22, weight: .semibold),
                                          color: .primaryTextColor)
    
    private lazy var amountLabel = UILabel(text: "Количество",
                                           font: .systemFont(ofSize: 16, weight: .medium),
                                           color: .primaryTextColor)
    
    private lazy var amountNumberLabel = UILabel(text: "\(coffeeAmount)",
                                                 font: .systemFont(ofSize: 18, weight: .medium),
                                                 color: .primaryTextColor)
    
    private lazy var sizeLabel = UILabel(text: "Размер",
                                         font: .systemFont(ofSize: 16, weight: .medium),
                                         color: .primaryTextColor)
    
    private lazy var dismissButton = UIButton(type: .close)
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(color: .primary, forState: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("Добавить в корзину", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private lazy var leftStepperButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: AppImageNames.stepperLeft)
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var rightStepperButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: AppImageNames.stepperRight)
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var sizeS = UILabel(text: "S", font: .systemFont(ofSize: 18, weight: .semibold), color: .primaryTextColor)
    private lazy var sizeM = UILabel(text: "M", font: .systemFont(ofSize: 18, weight: .semibold), color: .primaryTextColor)
    private lazy var sizeL = UILabel(text: "L", font: .systemFont(ofSize: 18, weight: .semibold), color: .primaryTextColor)
    
    private var coffeeSize: CoffeeSize = .medium
    private var coffeeAmount = 1
    
    private var prices: [String: Int] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.setImage(with: dish.image)
        priceLabel.text = "\(dish.prices[dish.sizes.first?.rawValue ?? CoffeeSize.medium.rawValue] ?? 0) ₽"
        
        sizeS.isHidden = true
        sizeM.isHidden = true
        sizeL.isHidden = true
        
        coffeeSize = dish.sizes.first ?? .small
        
        for size in dish.sizes {
            switch size {
            case .small:
                sizeS.isHidden = false
            case .medium:
                sizeM.isHidden = false
            case .large:
                sizeL.isHidden = false
            }
        }
        
        prices = dish.prices
        
        changeSizeSelection(size: coffeeSize)
    }
}

private extension DishConfigurationAlertView {
    func setup() {
        let views = [dishImageView, dishNameLabel, priceLabel, amountLabel,
                     sizeLabel, dismissButton, addToCartButton, leftStepperButton, amountNumberLabel, rightStepperButton, sizeS, sizeM, sizeL]
        
        addSubviews(views)
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        setupIntial()
        setupDishImageView()
        setupPriceLabel()
        setupDismissButton()
        setupAddToCartButton()
        setupLeftStepperButton()
        setupAmountNumberLabel()
        setupRightStepperButton()
        setupCoffeeSizes()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCoffeeSizes() {
        sizeS.translatesAutoresizingMaskIntoConstraints = false
        sizeM.translatesAutoresizingMaskIntoConstraints = false
        sizeL.translatesAutoresizingMaskIntoConstraints = false
        
        sizeS.textAlignment = .center
        sizeM.textAlignment = .center
        sizeL.textAlignment = .center
        
        sizeS.isUserInteractionEnabled = true
        sizeM.isUserInteractionEnabled = true
        sizeL.isUserInteractionEnabled = true
        
        let smallSizeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSmallSize))
        sizeS.addGestureRecognizer(smallSizeTapRecognizer)
        
        let mediumSizeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMediumSize))
        
        sizeM.addGestureRecognizer(mediumSizeTapRecognizer)
        
        let largeSizeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLargeSize))
        sizeL.addGestureRecognizer(largeSizeTapRecognizer)
    }
    
    func setupAmountNumberLabel() {
        amountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        amountNumberLabel.textAlignment = .center
    }
    
    func setupAddToCartButton() {
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
    }
    
    func setupIntial() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
    }
    
    func setupDishImageView() {
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishImageView.layer.cornerRadius = 16
    }
    
    func setupDismissButton() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLeftStepperButton() {
        leftStepperButton.translatesAutoresizingMaskIntoConstraints = false
        leftStepperButton.addTarget(self, action: #selector(didTapLeftStepperButton), for: .touchUpInside)
    }
    
    func setupRightStepperButton() {
        rightStepperButton.translatesAutoresizingMaskIntoConstraints = false
        rightStepperButton.addTarget(self, action: #selector(didTapRightStepperButton), for: .touchUpInside)
    }
    
    func layout() {
        layoutDishImageView()
        layoutDismissButton()
        layoutDishNameLabel()
        layoutPriceLabel()
        layoutAddToCartButton()
        layoutAmountLabel()
        layoutLeftStepperButton()
        layoutAmountNumberLabel()
        layoutRightStepperButton()
        layoutSizeLabel()
        layoutCoffeeSizes()
    }
    
    func layoutCoffeeSizes() {
        sizeS.sizeToFit()
        sizeM.sizeToFit()
        sizeL.sizeToFit()
        
        NSLayoutConstraint.activate([
            sizeS.centerYAnchor.constraint(equalTo: sizeLabel.centerYAnchor),
            sizeS.leadingAnchor.constraint(equalTo: leftStepperButton.leadingAnchor),
            sizeS.trailingAnchor.constraint(equalTo: leftStepperButton.trailingAnchor),
            
            sizeL.centerYAnchor.constraint(equalTo: sizeLabel.centerYAnchor),
            sizeL.leadingAnchor.constraint(equalTo: rightStepperButton.leadingAnchor),
            sizeL.trailingAnchor.constraint(equalTo: rightStepperButton.trailingAnchor),
            
            sizeM.centerYAnchor.constraint(equalTo: sizeLabel.centerYAnchor),
            sizeM.leadingAnchor.constraint(equalTo: sizeS.trailingAnchor, constant: 14),
            sizeM.trailingAnchor.constraint(equalTo: sizeL.leadingAnchor, constant: -14)
        ])
    }
    
    func layoutSizeLabel() {
        sizeLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            sizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            sizeLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 24),
            sizeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func layoutAmountNumberLabel() {
        amountNumberLabel.sizeToFit()
        NSLayoutConstraint.activate([
            amountNumberLabel.trailingAnchor.constraint(equalTo: rightStepperButton.leadingAnchor, constant: -24),
            amountNumberLabel.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            amountNumberLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func layoutRightStepperButton() {
        NSLayoutConstraint.activate([
            rightStepperButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            rightStepperButton.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            rightStepperButton.widthAnchor.constraint(equalToConstant: 31),
            rightStepperButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    func layoutAddToCartButton() {
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 30),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    func layoutPriceLabel() {
        priceLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: dishNameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func layoutDishNameLabel() {
        dishNameLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 22),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            dishNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 34)
        ])
    }
    
    func layoutDishImageView() {
        NSLayoutConstraint.activate([
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            dishImageView.heightAnchor.constraint(equalToConstant: 88),
            dishImageView.widthAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    func layoutDismissButton() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 16),
            dismissButton.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func layoutLeftStepperButton() {
        NSLayoutConstraint.activate([
            leftStepperButton.trailingAnchor.constraint(equalTo: amountNumberLabel.leadingAnchor, constant: -24),
            leftStepperButton.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            leftStepperButton.widthAnchor.constraint(equalToConstant: 31),
            leftStepperButton.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    func layoutAmountLabel() {
        amountLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            amountLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 40)
        ])
    }
    
    func changeSizeSelection(size: CoffeeSize) {
        switch coffeeSize {
        case .small:
            sizeS.textColor = .primaryTextColor
        case .medium:
            sizeM.textColor = .primaryTextColor
        case .large:
            sizeL.textColor = .primaryTextColor
        }
        
        switch size {
        case .small:
            sizeS.textColor = .primary
        case .medium:
            sizeM.textColor = .primary
        case .large:
            sizeL.textColor = .primary
        }
        
        priceLabel.text = "\(prices[size.rawValue] ?? 0) ₽"
    }
    
    @objc func didTapSmallSize() {
        changeSizeSelection(size: .small)
        coffeeSize = .small
    }
    
    @objc func didTapMediumSize() {
        changeSizeSelection(size: .medium)
        coffeeSize = .medium
    }
    
    @objc func didTapLargeSize() {
        changeSizeSelection(size: .large)
        coffeeSize = .large
    }
    
    @objc func didTapLeftStepperButton() {
        if coffeeAmount > 1 {
            coffeeAmount -= 1
            amountNumberLabel.text = "\(coffeeAmount)"
        }
    }
    
    @objc func didTapRightStepperButton() {
        if coffeeAmount < 10 {
            coffeeAmount += 1
            amountNumberLabel.text = "\(coffeeAmount)"
        }
    }
    
    @objc func didTapClose() {
        delegate?.didTapClose()
    }
    
    @objc func didTapAddToCart() {
        guard let coffeePrice = prices[coffeeSize.rawValue] else {
            return
        }
        delegate?.didTapAddToCart(amount: coffeeAmount, price: coffeePrice)
    }
}
