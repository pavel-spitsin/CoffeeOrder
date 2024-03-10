//
//  EnterInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

protocol EnterInteractorProtocol: AnyObject {
    func enterUser(with email: String, and password: String)
}

class EnterInteractor {
    //MARK: - Property
    weak var presenter: EnterPresenterProtocol?
    private let coffeeShopService = CoffeeShopService()

    //MARK: - Private functions
    private func enteringCompleted() {
        presenter?.enteringCompleted()
    }
}

extension EnterInteractor: EnterInteractorProtocol {
    func enterUser(with email: String, and password: String) {
        coffeeShopService.userEnter(email: email, password: password, completion: enteringCompleted)
    }
}
