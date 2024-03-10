//
//  MapModuleBuilder.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024
//

class MapModuleBuilder {
    static func build(locations: [CoffeeShop]) -> MapViewController {
        let interactor = MapInteractor()
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router)
        let viewController = MapViewController(locations: locations)
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
