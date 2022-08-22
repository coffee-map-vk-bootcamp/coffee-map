//
//  CoffeeShopBottomSheetDataSource.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 19.08.2022.
//

import UBottomSheet

final class CoffeeShopBottomSheetDataSource: UBottomSheetCoordinatorDataSource {
    func sheetPositions(_ availableHeight: CGFloat) -> [CGFloat] {
        return [0.1, 0.35, 0.75, 1.1].map { $0 * availableHeight }
    }
    
    func initialPosition(_ availableHeight: CGFloat) -> CGFloat {
        return availableHeight * 0.35
    }
}
