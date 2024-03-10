//
//  RegistrationRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024
//

import Foundation

protocol RegistrationRouterProtocol {
    func openEnterScreen()
}

class RegistrationRouter {
    //MARK: - Property
    weak var viewController: RegistrationViewController?
}

//MARK: - RegistrationRouterProtocol
extension RegistrationRouter: RegistrationRouterProtocol {
    func openEnterScreen() {
        DispatchQueue.main.async {
            let vc = EnterModuleBuilder.build()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
