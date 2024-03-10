//
//  DialogButton.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024.
//

import UIKit

enum DialogButtonType: Int {
    case open
    case close
}

class DialogButton: UIButton {
    //MARK: - Property
    private let type: DialogButtonType
    var isActive: Bool {
        didSet {
            checkActivity()
        }
    }
    
    //MARK: - Init
    init(buttonType: DialogButtonType, title: String, isActive: Bool = true) {
        self.type = buttonType
        self.isActive = isActive
        super.init(frame: .zero)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        setTitle(title, for: .normal)
        
        switch buttonType {
        case .open:
            backgroundColor = .clear
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.customBrownDark.cgColor
            setTitleColor(UIColor.customBrownDark, for: .normal)
        case .close:
            backgroundColor = UIColor.customBrownDark
            titleLabel?.textColor = UIColor.customBeige
            setTitleColor(UIColor.customBeige, for: .normal)
        }
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height * 0.5
        checkActivity()
    }
    
    //MARK: - Private functions
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func checkActivity() {
        if isActive {
            alpha = 1
            isUserInteractionEnabled = true
        } else {
            alpha = 0.3
            isUserInteractionEnabled = false
        }
    }
}
