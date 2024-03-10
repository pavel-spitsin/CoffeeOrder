//
//  RegistrationModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024
//

class RegistrationModuleBuilder {
    static func build() -> RegistrationViewController {
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(interactor: interactor, router: router)
        let viewController = RegistrationViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
