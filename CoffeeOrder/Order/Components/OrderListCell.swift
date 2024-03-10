//
//  OrderListCell.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024.
//

import Foundation
import UIKit

protocol OrderListCellDelegate: AnyObject{
    func minusButtonAction(item: Coffee, count: UInt)
    func plusButtonAction(item: Coffee, count: UInt)
}

class OrderListCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = String(describing: OrderListCell.self)
    weak var delegate: OrderListCellDelegate?
    var coffee: Coffee? {
        didSet {
            nameLabel.text = coffee?.name
            if let priceValue = coffee?.price {
                priceLabel.text = String(priceValue) + " руб"
            }
        }
    }
    var itemCount: UInt = 0 {
        didSet {
            countLabel.text = String(itemCount)
        }
    }
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownMedium
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownLight
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    private lazy var plusButton: PlusMinusButton = {
        let button = PlusMinusButton(buttonType: .plus)
        button.setTitleColor(UIColor.customBrownMedium, for: .normal)
        button.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var minusButton: PlusMinusButton = {
        let button = PlusMinusButton(buttonType: .minus)
        button.setTitleColor(UIColor.customBrownMedium, for: .normal)
        button.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownMedium
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = "0"
        return label
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureComponents()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 16))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemCount = 0
        nameLabel.text = ""
        priceLabel.text = ""
        countLabel.text = "\(itemCount)"
    }

    //MARK: - Private functions
    private func configureComponents() {
        backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = UIColor.customBeige
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 2
        contentView.layer.masksToBounds = false
    }

    private func setupLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(minusButton)
        contentView.addSubview(countLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 25),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 28),
            countLabel.heightAnchor.constraint(equalToConstant: 17),
            countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor),
        ])
    }

    @objc private func plusButtonAction() {
        self.itemCount += 1
        guard let coffee else { return }
        delegate?.plusButtonAction(item: coffee, count: itemCount)
    }
    
    @objc private func minusButtonAction() {
        if itemCount > 0 {
            self.itemCount -= 1
        } else {
            self.itemCount = 0
        }
        guard let coffee else { return }
        delegate?.minusButtonAction(item: coffee, count: itemCount)
    }
}
