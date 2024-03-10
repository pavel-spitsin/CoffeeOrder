//
//  StartInteractor.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

protocol StartInteractorProtocol: AnyObject {
}

class StartInteractor {
    //MARK: - Property
    weak var presenter: StartPresenterProtocol?
}

//MARK: - StartInteractorProtocol
extension StartInteractor: StartInteractorProtocol {
}
