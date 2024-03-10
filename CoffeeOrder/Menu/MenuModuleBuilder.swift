//
//  MenuModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024
//

class MenuModuleBuilder {
    static func build(locationID: Int) -> MenuViewController {
        let interactor = MenuInteractor(locationID: locationID)
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let viewController = MenuViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
