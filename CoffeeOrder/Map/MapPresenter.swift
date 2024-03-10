//
//  MapPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024
//

protocol MapPresenterProtocol: AnyObject {
    func getUserLocation()
    func didSelectCoffeeShop(location: CoffeeShop)
}

class MapPresenter {
    //MARK: - Property
    weak var view: MapViewProtocol?
    var router: MapRouterProtocol
    var interactor: MapInteractorProtocol

    //MARK: - Init
    init(interactor: MapInteractorProtocol, router: MapRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - MapPresenterProtocol
extension MapPresenter: MapPresenterProtocol {
    func getUserLocation() {
        interactor.getUserLocation { (lat, lon) in
            view?.showUserLocation(latitude: lat, longitude: lon)
        }
    }
    
    func didSelectCoffeeShop(location: CoffeeShop) {
        interactor.didSelectCoffeeShop()
        router.openMenuForLocation(withID: location.id)
    }
}
