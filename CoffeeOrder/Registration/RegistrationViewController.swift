//
//  RegistrationViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func registrationButtonErrorAnimation()
}

class RegistrationViewController: BaseViewController, UITextFieldDelegate {
    //MARK: - Property
    var presenter: RegistrationPresenterProtocol?
    private lazy var emailTextField: RoundedTextField = {
        let textField = RoundedTextField(title: "e-mail", type: .openText)
        return textField
    }()
    private lazy var passwordTextField: RoundedTextField = {
        let textField = RoundedTextField(title: "Пароль", type: .hiddenText)
        return textField
    }()
    private lazy var passwordConfirmTextField: RoundedTextField = {
        let textField = RoundedTextField(title: "Повторите пароль", type: .hiddenText)
        return textField
    }()
    private lazy var registrationButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "Регистрация")
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Регистрация"
        initialize()
    }
}

//MARK: - Private functions
private extension RegistrationViewController {
    func initialize() {
        fillStackView()
        setupLayout()
    }
    
    func fillStackView() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordConfirmTextField)
        stackView.setCustomSpacing(30, after: passwordConfirmTextField)
        stackView.addArrangedSubview(registrationButton)
    }
    
    func setupLayout() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func registrationButtonAction() {
        presenter?.didTapRegistrationButton(email: emailTextField.textField.text,
                                            password: passwordTextField.textField.text,
                                            passwordConfirm: passwordConfirmTextField.textField.text)
    }
}

//MARK: - RegistrationViewProtocol
extension RegistrationViewController: RegistrationViewProtocol {
    func registrationButtonErrorAnimation() {
        registrationButton.errorShakeAnimation()
    }
}
