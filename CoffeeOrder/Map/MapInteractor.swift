//
//  MapInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024
//

protocol MapInteractorProtocol: AnyObject {
    func getUserLocation(completion: (Double, Double) -> Void)
    func didSelectCoffeeShop()
}

class MapInteractor {
    //MARK: - Property
    weak var presenter: MapPresenterProtocol?
    private let locationService = LocationService()
}

//MARK: - MapInteractorProtocol
extension MapInteractor: MapInteractorProtocol {
    func getUserLocation(completion: (Double, Double) -> Void) {
        locationService.currentLocationRequest(completion: completion)
    }
    
    func didSelectCoffeeShop() {
        OrderCart.shared.clearOrder()
    }
}
