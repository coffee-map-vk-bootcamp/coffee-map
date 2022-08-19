//
//  ReceiptCellModel.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 15.08.2022.
//

import Foundation

struct ReceiptCellModel {
    let name: String
    let date: String
    let price: String
    let dishes: [OrderDish]
    var expandButtonAction: (() -> Void)?
}
