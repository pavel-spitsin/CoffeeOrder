//
//  CoffeeShopsInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024
//

protocol CoffeeShopsInteractorProtocol: AnyObject {
    func loadLocations()
    func getLocationID(index: Int) -> Int
    func getDistanceToCoffeeShop(coffeeShop: CoffeeShop, completion: (Double) -> Void)
    func didSelectCoffeeShop()
}

class CoffeeShopsInteractor {
    //MARK: - Property
    weak var presenter: CoffeeShopsPresenterProtocol?
    private let coffeeShopService = CoffeeShopService()
    private let locationService = LocationService()
    private var coffeeShops: [CoffeeShop] = [CoffeeShop]()
}

//MARK: - CoffeeShopsInteractorProtocol
extension CoffeeShopsInteractor: CoffeeShopsInteractorProtocol {
    func loadLocations() {
        coffeeShopService.getLocations { [weak self] locations in
            guard let self else { return }
            self.coffeeShops = locations
            self.presenter?.didLoad(locations: self.coffeeShops)
        }
    }
    
    func getLocationID(index: Int) -> Int {
        coffeeShops[index].id
    }
    
    func getDistanceToCoffeeShop(coffeeShop: CoffeeShop, completion: (Double) -> Void) {
        locationService.distanceRequest(coffeeShop: coffeeShop, completion: completion)
    }
    
    func didSelectCoffeeShop() {
        OrderCart.shared.clearOrder()
    }
}
