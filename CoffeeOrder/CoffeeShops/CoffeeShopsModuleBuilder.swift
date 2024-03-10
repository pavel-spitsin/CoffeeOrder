//
//  CoffeeShopsModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024
//

class CoffeeShopsModuleBuilder {
    static func build() -> CoffeeShopsViewController {
        let interactor = CoffeeShopsInteractor()
        let router = CoffeeShopsRouter()
        let presenter = CoffeeShopsPresenter(interactor: interactor, router: router)
        let viewController = CoffeeShopsViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
