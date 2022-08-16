//
//  FavouritesCell.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import UIKit

final class FavouritesCell: UICollectionViewCell {
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Название кофейни"
        label.textColor = .white
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Адрес кофейни"
        label.textColor = .white
        return label
    }()
    
    private lazy var flagButton: UIButton = {
        let btn = UIButton()
        let imageView = UIImageView()
        if let myImage = UIImage(named: AppImageNames.favorite) {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
        }
        btn.setImage(imageView.image, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(deleteFavourite), for: .touchUpInside)
        return btn
    }()
    
    private lazy var markImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: AppImageNames.mark)?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "1 км."
        label.textColor = .white
        return label
    }()
    
    private var distanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.layer.cornerRadius = 6
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layout()
        layoutDistanceView()
    }
    
    func configure(with shop: FavouritesPresenter.FavouriteCoffeeShop) {
        placeLabel.text = shop.name
        addressLabel.text = shop.address
    }
    
    private func setupViews() {
        let views = [distanceView, flagButton, addressLabel, placeLabel]
        contentView.addSubviews(views)
    }
    
    @objc private func deleteFavourite() {
        print("delete")
    }
    
    private func setupCell() {
        let background = UIImageView(image: UIImage(named: AppImageNames.mockHeader))
        background.frame = contentView.bounds
        background.contentMode =  UIView.ContentMode.scaleAspectFill
        background.clipsToBounds = true
        background.center = contentView.center
        background.layer.cornerRadius = 14
        contentView.addSubview(background)
        contentView.sendSubviewToBack(background)
    }
    
    private func layoutDistanceView() {
        distanceView.addSubview(markImage)
        distanceView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            markImage.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor),
            markImage.leadingAnchor.constraint(equalTo: distanceView.leadingAnchor),
            
            distanceLabel.leadingAnchor.constraint(equalTo: markImage.trailingAnchor, constant: -4),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor)
        ])
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            distanceView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            distanceView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            distanceView.widthAnchor.constraint(equalToConstant: 51),
            distanceView.heightAnchor.constraint(equalToConstant: 20),
            
            flagButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            flagButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -14),
            flagButton.heightAnchor.constraint(equalToConstant: 28),
            flagButton.widthAnchor.constraint(equalToConstant: 24),
            
            placeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            placeLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
