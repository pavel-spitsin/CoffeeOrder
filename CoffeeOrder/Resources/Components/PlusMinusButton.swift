//
//  PlusMinusButton.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024.
//

import UIKit

enum PlusMinusButtonType: Int {
    case plus
    case minus
}

class PlusMinusButton: UIButton {
    //MARK: - Property
    private let type: PlusMinusButtonType
    
    //MARK: - Init
    init(buttonType: PlusMinusButtonType) {
        self.type = buttonType
        super.init(frame: .zero)
        backgroundColor = .clear
        
        switch buttonType {
        case .plus:
            setTitle("+", for: .normal)
        case .minus:
            setTitle("-", for: .normal)
        }
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private functions
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 24),
            widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
