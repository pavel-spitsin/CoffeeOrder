//
//  OrderPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024
//

protocol OrderPresenterProtocol: AnyObject {
    func viewDidAppear()
    func payButtonTapped()
    func deliveryTimeAlertShowed()
}

class OrderPresenter {
    //MARK: - Property
    weak var view: OrderViewProtocol?
    var router: OrderRouterProtocol
    var interactor: OrderInteractorProtocol

    //MARK: - Init
    init(interactor: OrderInteractorProtocol, router: OrderRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - OrderPresenterProtocol
extension OrderPresenter: OrderPresenterProtocol {
    func viewDidAppear() {
        view?.showOrder(order: interactor.getOrder())
    }
    
    func payButtonTapped() {
        guard (interactor.getOrder()?.isEmpty == false) else {
            view?.payButtonErrorAnimation()
            return
        }
        interactor.playPaySound()
        view?.showDeliveryTimeAlert()
    }
    
    func deliveryTimeAlertShowed() {
        router.openCoffeeShopsScreen()
    }
}

//MARK: - OrderListCellDelegate
extension OrderPresenter: OrderListCellDelegate {
    func minusButtonAction(item: Coffee, count: UInt) {
        interactor.changeOrder(item: item, count: count)
    }
    
    func plusButtonAction(item: Coffee, count: UInt) {
        interactor.changeOrder(item: item, count: count)
    }
}
