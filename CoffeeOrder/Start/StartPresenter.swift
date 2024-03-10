//
//  StartPresenter.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

protocol StartPresenterProtocol: AnyObject {
    func didTapRegistrationButton()
    func didTapEnterButton()
}

class StartPresenter {
    //MARK: - Property
    weak var view: StartViewProtocol?
    var router: StartRouterProtocol
    var interactor: StartInteractorProtocol

    //MARK: - Init
    init(interactor: StartInteractorProtocol, router: StartRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - StartPresenterProtocol
extension StartPresenter: StartPresenterProtocol {
    func didTapRegistrationButton() {
        router.openRegistrationScreen()
    }
    
    func didTapEnterButton() {
        router.openEnterScreen()
    }
}
