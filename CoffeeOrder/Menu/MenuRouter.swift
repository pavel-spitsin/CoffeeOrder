//
//  MenuRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024
//

import Foundation

protocol MenuRouterProtocol {
    func openOrderScreen()
}

class MenuRouter {
    //MARK: - Property
    weak var viewController: MenuViewController?
}

//MARK: - MenuRouterProtocol
extension MenuRouter: MenuRouterProtocol {
    func openOrderScreen() {
        DispatchQueue.main.async {
            let vc = OrderModuleBuilder.build()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
