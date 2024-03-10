//
//  CoffeeShopListCell.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024.
//

import UIKit

protocol CoffeeShopListCellDelegate: AnyObject {
    func getDistanceToCoffeeShop(coffeeShop: CoffeeShop, completion: (Double) -> Void)
}

class CoffeeShopListCell: UITableViewCell {
    //MARK: - Property
    static let identifier = String(describing: CoffeeShopListCell.self)
    weak var delegate: CoffeeShopListCellDelegate?
    var location: CoffeeShop? {
        didSet {
            guard let location else { return }
            nameLabel.text = location.name
            delegate?.getDistanceToCoffeeShop(coffeeShop: location, completion: updateDistanceLabel(distance:))
        }
    }
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownMedium
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownLight
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
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
        nameLabel.text = ""
        distanceLabel.text = "..."
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
        contentView.addSubview(distanceLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: 21),
            distanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
        ])
    }
    
    private func updateDistanceLabel(distance: Double) {
        DispatchQueue.main.async {
            let formattedDistance = String(format: "%.2f", distance)
            self.distanceLabel.text = "\(formattedDistance) км от вас"
        }
    }
}
