//
//  CustomButton.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 11.08.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    private let title: String
    private let titleColor: UIColor
    private let isTapped: (() -> Void)?
    
    init(title: String, titleColor: UIColor, onTap: (() -> Void)?) {
        self.title = title
        self.titleColor = titleColor
        self.isTapped = onTap
            
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        isTapped?()
    }
}
