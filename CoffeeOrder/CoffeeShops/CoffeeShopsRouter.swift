//
//  CoffeeShopsRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024
//

import Foundation

protocol CoffeeShopsRouterProtocol {
    func openMenuForLocation(withID: Int)
    func openMapScreen(locations: [CoffeeShop])
}

class CoffeeShopsRouter {
    //MARK: - Property
    weak var viewController: CoffeeShopsViewController?
}

//MARK: - CoffeeShopsRouterProtocol
extension CoffeeShopsRouter: CoffeeShopsRouterProtocol {
    func openMenuForLocation(withID: Int) {
        DispatchQueue.main.async {
            let vc = MenuModuleBuilder.build(locationID: withID)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openMapScreen(locations: [CoffeeShop]) {
        DispatchQueue.main.async {
            let vc = MapModuleBuilder.build(locations: locations)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
