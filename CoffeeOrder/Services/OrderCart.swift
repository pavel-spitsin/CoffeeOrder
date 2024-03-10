//
//  Order.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024.
//

final class OrderCart {
    //MARK: - Property
    static let shared = OrderCart()
    private var order: [Coffee : UInt]? = [Coffee : UInt]()

    //MARK: - Init
    private init() {}
    
    //MARK: - Actions
    func updateOrder(item: Coffee, count: UInt) {
        if count == 0 {
            order?[item] = nil
        } else {
            order?[item] = count
        }
    }

    func getOrder() -> [Coffee : UInt]? {
        order
    }
    
    func clearOrder() {
        order?.removeAll()
    }
}
