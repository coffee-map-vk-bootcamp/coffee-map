//
//  CartScreenPresenter.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import Foundation

final class CartScreenPresenter {
    weak var view: CartScreenViewInput?
    weak var moduleOutput: CartScreenModuleOutput?
    
    private let router: CartScreenRouterInput
    private let interactor: CartScreenInteractorInput
    private var cartList: CartList
    
    init(router: CartScreenRouterInput, interactor: CartScreenInteractorInput, cartList: CartList) {
        self.router = router
        self.interactor = interactor
        // MARK: - Mock list
        let mockList = CartList()
        mockList.coffeeShop = "Surf Coffee x Wave"
        let dish = OrderDish.init(name: "Капучино",
                                  price: 189,
                                  image: "https://firebasestorage.googleapis.com/v0/b/coffeemapvk-89b14.appspot.com/o/images%2FB4865BCD-A5CD-4CD6-84E3-1861A735C8DF.jpeg?alt=media&token=b839ca49-2118-4465-94da-e66a775abf47",
                                  count: 2)
        let dish1 = OrderDish.init(name: "Латте",
                                   price: 229,
                                   image: "https://firebasestorage.googleapis.com/v0/b/coffeemapvk-89b14.appspot.com/o/EACE22B9-44C5-4815-863E-DAC3AA3AB7F2.jpeg?alt=media&token=afb03a7e-e3a0-4af4-b0b3-a3507f58c38e",
                                   count: 2)
        mockList.dishes.append(dish)
        mockList.dishes.append(dish1)
        self.cartList = mockList
    }
}

extension CartScreenPresenter: CartScreenModuleInput {
}

extension CartScreenPresenter: CartScreenViewOutput {
    var coffeeShopName: String {
        interactor.coffeeShopName
    }
    
    var price: Int {
        interactor.price
    }

    func deleteDishFromOrder(at index: Int) {
        interactor.deleteDishFromOrder(at: index)
    }

    func makeOrder(name: String, time: Date, completion: @escaping (Result<Void, Error>) -> Void) {
        interactor.makeOrder(name: name, time: time, completion: completion)
    }

    var dishList: [OrderDish] {
        interactor.dishList
    }
}

extension CartScreenPresenter: CartScreenInteractorOutput {
}
