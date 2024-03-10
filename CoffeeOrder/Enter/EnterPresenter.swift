//
//  EnterPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

protocol EnterPresenterProtocol: AnyObject {
    func didTapEnterButton(email: String?, password: String?)
    func enteringCompleted()
}

class EnterPresenter {
    //MARK: - Property
    weak var view: EnterViewProtocol?
    var router: EnterRouterProtocol
    var interactor: EnterInteractorProtocol

    //MARK: - Init
    init(interactor: EnterInteractorProtocol, router: EnterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - EnterPresenterProtocol
extension EnterPresenter: EnterPresenterProtocol {
    func didTapEnterButton(email: String?, password: String?) {
        guard
            let email,
            let password,
            email.isEmpty == false,
            password.isEmpty == false
        else {
            view?.enterButtonErrorAnimation()
            return
        }
        interactor.enterUser(with: email, and: password)
    }
    
    func enteringCompleted() {
        router.openCoffeeShopsScreen()
    }
}
