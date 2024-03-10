//
//  OrderRouter.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024
//

import UIKit

protocol OrderRouterProtocol {
    func openCoffeeShopsScreen()
}

class OrderRouter {
    //MARK: - Property
    weak var viewController: OrderViewController?
}

//MARK: - OrderRouterProtocol
extension OrderRouter: OrderRouterProtocol {
    func openCoffeeShopsScreen() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let navVC = appDelegate?.window?.rootViewController as? UINavigationController
            navVC?.popToViewController(ofClass: CoffeeShopsViewController.self)
        }
    }
}
