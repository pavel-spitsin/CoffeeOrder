//
//  RoundedTextField.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024.
//

import UIKit

enum CustomTextFieldType: Int {
    case openText
    case hiddenText
}

class RoundedTextField: UIView, UITextFieldDelegate {
    //MARK: - Property
    private let type: CustomTextFieldType
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        return textField
    }()
    
    //MARK: - Init
    init(title: String, type: CustomTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        titleLabel.text = title
        
        switch type {
        case .openText:
            textField.isSecureTextEntry = false
        case .hiddenText:
            textField.isSecureTextEntry = true
        }
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.layer.cornerRadius = textField.bounds.size.height * 0.5
        textField.setLeftPadding(textField.layer.cornerRadius)
    }

    //MARK: - Private functions
    private func setupViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = UIColor.customBrownMedium
        titleLabel.backgroundColor = .clear
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.customBrownMedium.cgColor
        textField.layer.borderWidth = 2
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.textColor = UIColor.customBrownLight
        textField.tintColor = UIColor.customBrownLight
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 47),
            
            heightAnchor.constraint(equalToConstant: 73),
        ])
    }
}
