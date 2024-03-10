//
//  OrderInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024
//

protocol OrderInteractorProtocol: AnyObject {
    func getOrder() -> [Coffee : UInt]?
    func changeOrder(item: Coffee, count: UInt)
    func playPaySound()
}

class OrderInteractor {
    //MARK: - Property
    weak var presenter: OrderPresenterProtocol?
}

//MARK: - OrderInteractorProtocol
extension OrderInteractor: OrderInteractorProtocol {
    func getOrder() -> [Coffee : UInt]? {
        OrderCart.shared.getOrder()
    }
    
    func changeOrder(item: Coffee, count: UInt) {
        OrderCart.shared.updateOrder(item: item, count: count)
    }
    
    func playPaySound() {
        SoundPlayer.shared.playSound()
    }
}
