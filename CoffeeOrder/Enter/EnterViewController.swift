//
//  EnterViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024
//

import UIKit

protocol EnterViewProtocol: AnyObject {
    func enterButtonErrorAnimation()
}

class EnterViewController: BaseViewController {
    //MARK: - Property
    var presenter: EnterPresenterProtocol?
    private lazy var emailTextField: RoundedTextField = {
        let textField = RoundedTextField(title: "e-mail", type: .openText)
        return textField
    }()
    private lazy var passwordTextField: RoundedTextField = {
        let textField = RoundedTextField(title: "Пароль", type: .hiddenText)
        return textField
    }()
    private lazy var enterButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "Вход")
        button.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
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
        navigationItem.title = "Вход"
        initialize()
    }
}

//MARK: - Private functions
private extension EnterViewController {
    func initialize() {
        fillStackView()
        setupLayout()
    }
    
    func fillStackView() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.setCustomSpacing(30, after: passwordTextField)
        stackView.addArrangedSubview(enterButton)
    }
    
    func setupLayout() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).withPriority(750),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
        ])
    }
    
    @objc func enterButtonAction() {
        presenter?.didTapEnterButton(email: emailTextField.textField.text,
                                     password: passwordTextField.textField.text)
    }
}

//MARK: - EnterViewProtocol
extension EnterViewController: EnterViewProtocol {
    @objc func enterButtonErrorAnimation() {
        enterButton.errorShakeAnimation()
    }
}
