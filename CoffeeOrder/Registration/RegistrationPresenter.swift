//
//  RegistrationPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024
//

protocol RegistrationPresenterProtocol: AnyObject {
    func didTapRegistrationButton(email: String?, password: String?, passwordConfirm: String?)
    func registrationCompleted()
}

class RegistrationPresenter {
    //MARK: - Property
    weak var view: RegistrationViewProtocol?
    var router: RegistrationRouterProtocol
    var interactor: RegistrationInteractorProtocol

    //MARK: - Init
    init(interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - RegistrationPresenterProtocol
extension RegistrationPresenter: RegistrationPresenterProtocol {
    func didTapRegistrationButton(email: String?, password: String?, passwordConfirm: String?) {
        guard 
            let email,
            let password,
            let passwordConfirm,
            email.isEmpty == false,
            password.isEmpty == false,
            passwordConfirm.isEmpty == false,
            password == passwordConfirm
        else {
            view?.registrationButtonErrorAnimation()
            return
        }
        interactor.registerUser(with: email, and: password)
    }
    
    func registrationCompleted() {
        router.openEnterScreen()
    }
}
