//
//  StartRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

import Foundation

protocol StartRouterProtocol {
    func openRegistrationScreen()
    func openEnterScreen()
}

class StartRouter {
    //MARK: - Property
    weak var viewController: StartViewController?
}

//MARK: - StartRouterProtocol
extension StartRouter: StartRouterProtocol {
    func openRegistrationScreen() {
        DispatchQueue.main.async {
            let vc = RegistrationModuleBuilder.build()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openEnterScreen() {
        DispatchQueue.main.async {
            let vc = EnterModuleBuilder.build()
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
