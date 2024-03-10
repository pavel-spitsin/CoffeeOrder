//
//  MenuInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024
//

import UIKit

protocol MenuInteractorProtocol: AnyObject {
    func loadMenuForLocation()
    func getOrder() -> [Coffee : UInt]?
    func changeOrder(item: Coffee, count: UInt)
    func getItemImage(imageURL: String, completion: @escaping ((UIImage) -> Void))
}

class MenuInteractor {
    //MARK: - Property
    weak var presenter: MenuPresenterProtocol?
    private let coffeeShopService = CoffeeShopService()
    private let locationID: Int
    
    //MARK: - Init
    init(presenter: MenuPresenterProtocol? = nil, locationID: Int) {
        self.presenter = presenter
        self.locationID = locationID
    }
}

//MARK: - MenuInteractorProtocol
extension MenuInteractor: MenuInteractorProtocol {
    func loadMenuForLocation() {
        coffeeShopService.getLocationMenu(locationID: locationID) { [weak self] menu in
            guard let self else { return }
            self.presenter?.didLoad(menu: menu)
        }
    }
    
    func getOrder() -> [Coffee : UInt]? {
        OrderCart.shared.getOrder()
    }

    func changeOrder(item: Coffee, count: UInt) {
        OrderCart.shared.updateOrder(item: item, count: count)
    }
    
    func getItemImage(imageURL: String, completion: @escaping ((UIImage) -> Void)) {
        coffeeShopService.loadImage(imageURL: imageURL, completion: completion)
    }
}
