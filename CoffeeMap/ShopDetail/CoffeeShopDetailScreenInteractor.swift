//
//  CoffeeShopDetailScreenInteractor.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import Foundation

final class CoffeeShopDetailScreenInteractor {
    weak var output: CoffeeShopDetailScreenInteractorOutput?
    
    private var sections = [DishSection]()
    private var coffeeShop: CoffeeShop?
    
    private var networkService = FBService()
    
    func setCoffeeShop(_ coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        prepareData(for: coffeeShop)
    }
}

extension CoffeeShopDetailScreenInteractor: CoffeeShopDetailScreenInteractorInput {
    func addToFavorites() {
        if let coffeeShop = coffeeShop {
            networkService.addFavoriteCoffeeShop(with: coffeeShop.id) { result in
                switch result {
                case .success():
                    print("Add CoffeeShop to Favorites")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func removeFromFavorites() {
        if let coffeeShop = coffeeShop {
            networkService.deleteFavoriteCoffeeShop(with: coffeeShop.id) { result in
                switch result {
                case .success():
                    print("Remove CoffeeShop from Favorites")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCoffeeShop() -> CoffeeShop {
        return coffeeShop ?? .init()
    }
    
    func loadItems() -> [DishSection] {
        return sections
    }
    
    func checkIsFavorite() {
        networkService.addCoffeeShopsSubscription { [weak self] result in
            switch result {
            case .success(let shops):
                self?.networkService.fetchUserData { userResult in
                    switch userResult {
                    case .success(let user):
                        let favoriteShops = shops.filter { user.favoriteCoffeeShops.contains($0.id)}
                        self?.output?.setFavoriteCoffeeShops(favoriteShops)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let  error):
                print(error)
            }
        }
    }
}

private extension CoffeeShopDetailScreenInteractor {
    func prepareData(for coffeeShop: CoffeeShop) {
        let drinksSection = DishSection(sectionTitle: "Drinks", dishes: coffeeShop.drinks)
        let dishSection = DishSection(sectionTitle: "Dishes", dishes: coffeeShop.dishes)
        
        var totalSections: [DishSection] = []
        if drinksSection.dishes.count > 0 {
            totalSections.append(drinksSection)
        }
        
        if dishSection.dishes.count > 0 {
            totalSections.append(dishSection)
        }
        
        sections = totalSections
    }
}
