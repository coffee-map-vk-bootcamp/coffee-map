//
//  ProfilePresenter.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//  
//

import Foundation

final class ProfilePresenter {
	weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?

	private let router: ProfileRouterInput
	private let interactor: ProfileInteractorInput

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, dd.MM.yy"

        return formatter
    }()

    private var orders = [Order]()

    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    
    func logout() {
        router.logout()
    }
    
    func prepare(data model: Order) -> ReceiptCellModel {
        return ReceiptCellModel(name: model.name,
                                date: formatter.string(from: model.date),
                                price: "\(model.totalPrice) ₽",
                                dishes: model.dishes)
    }

    var count: Int {
        return orders.count
    }

    func item(at index: Int) -> Order {
        return orders[index]
    }

    func loadUser() {
        interactor.obtainUser()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    func didObtain(_ user: User) {
        orders = user.orders
        view?.didLoad(user: user)
    }

    func didFail(with error: Error) {
        view?.didLoad(user: User(name: "Ошбика загрузки данных", favoriteCoffeeShops: [], orders: [], image: ""))
    }

}
