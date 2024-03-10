//
//  OrderModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024
//

class OrderModuleBuilder {
    static func build() -> OrderViewController {
        let interactor = OrderInteractor()
        let router = OrderRouter()
        let presenter = OrderPresenter(interactor: interactor, router: router)
        let viewController = OrderViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
