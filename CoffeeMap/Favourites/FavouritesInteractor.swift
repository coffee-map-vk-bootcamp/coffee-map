//
//  FavouritesInteractor.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import Foundation

final class FavouritesInteractor {
    weak var output: FavouritesInteractorOutput?
}

extension FavouritesInteractor: FavouritesInteractorInput {
    func loadItems() {
        print("[DEBUG] MOCK Load Data")
    }
}
