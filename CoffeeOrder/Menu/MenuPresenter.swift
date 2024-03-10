//
//  MenuPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    func viewDidAppear()
    func didLoad(menu: [Coffee])
    func checkOrder() -> [Coffee : UInt]?
    func toOrderTapped()
}

class MenuPresenter {
    //MARK: - Property
    weak var view: MenuViewProtocol?
    var router: MenuRouterProtocol
    var interactor: MenuInteractorProtocol

    //MARK: - Init
    init(interactor: MenuInteractorProtocol, router: MenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - MenuPresenterProtocol
extension MenuPresenter: MenuPresenterProtocol {
    func viewDidAppear() {
        interactor.loadMenuForLocation()
    }
    
    func didLoad(menu: [Coffee]) {
        view?.showMenu(menu: menu)
    }

    func toOrderTapped() {
        router.openOrderScreen()
    }
    
    func checkOrder() -> [Coffee : UInt]? {
        interactor.getOrder()
    }
}

//MARK: - MenuListCellDelegate
extension MenuPresenter: MenuListCellDelegate {
    func minusButtonAction(item: Coffee, count: UInt) {
        interactor.changeOrder(item: item, count: count)
    }
    
    func plusButtonAction(item: Coffee, count: UInt) {
        interactor.changeOrder(item: item, count: count)
    }
    
    func getItemImage(imageURL: String, completion: @escaping ((UIImage) -> Void)) {
        interactor.getItemImage(imageURL: imageURL, completion: completion)
    }
}
