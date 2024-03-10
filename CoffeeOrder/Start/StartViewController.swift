//
//  StartViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

import UIKit

protocol StartViewProtocol: AnyObject {
}

class StartViewController: BaseViewController {
    //MARK: - Property
    var presenter: StartPresenterProtocol?
    private lazy var registrationButton: DialogButton = {
        let button = DialogButton(buttonType: .open, title: "Регистрация")
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var enterButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "Вход")
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - Private functions
private extension StartViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(registrationButton)
        view.addSubview(enterButton)
        
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -4),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            enterButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 4),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func registrationButtonAction() {
        presenter?.didTapRegistrationButton()
    }
    
    @objc func enterButtonAction() {
        presenter?.didTapEnterButton()
    }
}

//MARK: - StartViewProtocol
extension StartViewController: StartViewProtocol {
}
