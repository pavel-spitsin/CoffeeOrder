//
//  MapRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024
//

import Foundation

protocol MapRouterProtocol {
    func openMenuForLocation(withID: Int)
}

class MapRouter {
    //MARK: - Property
    weak var viewController: MapViewController?
}

//MARK: - MapRouterProtocol
extension MapRouter: MapRouterProtocol {
    func openMenuForLocation(withID: Int) {
        DispatchQueue.main.async {
            let vc = MenuModuleBuilder.build(locationID: withID)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
