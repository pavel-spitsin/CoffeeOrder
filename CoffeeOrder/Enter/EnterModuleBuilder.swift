//
//  EnterModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

class EnterModuleBuilder {
    static func build() -> EnterViewController {
        let interactor = EnterInteractor()
        let router = EnterRouter()
        let presenter = EnterPresenter(interactor: interactor, router: router)
        let viewController = EnterViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
