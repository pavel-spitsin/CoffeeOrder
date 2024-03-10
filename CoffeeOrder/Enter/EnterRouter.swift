//
//  EnterRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

import Foundation

protocol EnterRouterProtocol {
    func openCoffeeShopsScreen()
}

class EnterRouter {
    //MARK: - Property
    weak var viewController: EnterViewController?
}

//MARK: - EnterRouterProtocol
extension EnterRouter: EnterRouterProtocol {
    func openCoffeeShopsScreen() {
        DispatchQueue.main.async {
            let vc = CoffeeShopsModuleBuilder.build()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
