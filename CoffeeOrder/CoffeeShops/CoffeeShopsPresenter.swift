//
//  CoffeeShopsPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024
//

protocol CoffeeShopsPresenterProtocol: AnyObject {
    func viewDidAppear()
    func didLoad(locations: [CoffeeShop])
    func didSelectRow(at index: Int)
    func toMapButtonTapped(locations: [CoffeeShop])
}

class CoffeeShopsPresenter {
    //MARK: - Property
    weak var view: CoffeeShopsViewProtocol?
    var router: CoffeeShopsRouterProtocol
    var interactor: CoffeeShopsInteractorProtocol

    //MARK: - Init
    init(interactor: CoffeeShopsInteractorProtocol, router: CoffeeShopsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - CoffeeShopsPresenterProtocol
extension CoffeeShopsPresenter: CoffeeShopsPresenterProtocol {
    func viewDidAppear() {
        interactor.loadLocations()
    }
    
    func didLoad(locations: [CoffeeShop]) {
        view?.showLocations(locations: locations)
    }
    
    func didSelectRow(at index: Int) {
        interactor.didSelectCoffeeShop()
        router.openMenuForLocation(withID: interactor.getLocationID(index: index))
    }
    
    func toMapButtonTapped(locations: [CoffeeShop]) {
        router.openMapScreen(locations: locations)
    }
}

//MARK: - CoffeeShopListCellDelegate
extension CoffeeShopsPresenter: CoffeeShopListCellDelegate {
    func getDistanceToCoffeeShop(coffeeShop: CoffeeShop, completion: (Double) -> Void) {
        interactor.getDistanceToCoffeeShop(coffeeShop: coffeeShop, completion: completion)
    }
}
