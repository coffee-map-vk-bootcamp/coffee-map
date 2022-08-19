//
//  SkeletonImageView.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 17.08.2022.
//

import Foundation
import UIKit

final class SkeletonImageView: UIImageView {
    private let imageManager = ImageManager.shared

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.lightGray.cgColor,
                                UIColor.white.cgColor,
                                UIColor.lightGray.cgColor]

        return gradientLayer
    }()

    private var isAnimationRunning = false

    private var lastRequestUrl: String?

    var errorPlaceholder: UIImage?

    init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
        gradientLayer.isHidden = true
        setupImageView()
        startAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }

    func setImage(with urlPath: String) {
        startAnimation()

        guard let url = URL(string: urlPath) else {
            return
        }

        if let lastRequestUrl = lastRequestUrl {
            if lastRequestUrl == urlPath {
                return
            } else {
                imageManager.cancel(with: lastRequestUrl)
                self.lastRequestUrl = nil
            }
        }

        imageManager.loadImage(with: url) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case.success(let newImage):
                self.image = newImage
            case .failure:
                if let errorPlaceholder = self.errorPlaceholder {
                    self.image = errorPlaceholder
                } else if let errorImage = UIImage(named: "error_load_image") {
                    self.image = errorImage
                }
            }
            self.stopAnimation()
        }
    }

    private func setupImageView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

    private func startAnimation() {
        guard !isAnimationRunning else {
            return
        }
        isAnimationRunning = true
        gradientLayer.isHidden = false

        let startLocations: [NSNumber] = [-1, -0.5, 0]
        let endLocations: [NSNumber] = [1, 1.5, 2]
        gradientLayer.locations = startLocations

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    private func stopAnimation() {
        isAnimationRunning = false
        gradientLayer.isHidden = true
        gradientLayer.removeAllAnimations()
    }
}
