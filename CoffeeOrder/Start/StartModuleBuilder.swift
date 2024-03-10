//
//  StartModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

class StartModuleBuilder {
    static func build() -> StartViewController {
        let interactor = StartInteractor()
        let router = StartRouter()
        let presenter = StartPresenter(interactor: interactor, router: router)
        let viewController = StartViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
