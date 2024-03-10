//
//  RegistrationInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024
//

protocol RegistrationInteractorProtocol: AnyObject {
    func registerUser(with email: String, and password: String)
}

class RegistrationInteractor {
    //MARK: - Property
    weak var presenter: RegistrationPresenterProtocol?
    private let coffeeShopService = CoffeeShopService()
    
    //MARK: - Private functions
    private func registrationCompleted() {
        presenter?.registrationCompleted()
    }
}

//MARK: - RegistrationInteractorProtocol
extension RegistrationInteractor: RegistrationInteractorProtocol {
    func registerUser(with email: String, and password: String) {
        coffeeShopService.userRegistration(email: email,
                                           password: password,
                                           completion: registrationCompleted)
    }
}
