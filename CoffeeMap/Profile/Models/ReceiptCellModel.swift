//
//  ReceiptCellModel.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 15.08.2022.
//

import Foundation

struct ReceiptCellModel {
    let name: String
    let dateText: String
    let date: Date
    let price: String
    let dishes: [OrderDish]
    var expandButtonAction: (() -> Void)?
}
