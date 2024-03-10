//
//  MenuListCell.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024.
//

import UIKit

protocol MenuListCellDelegate: AnyObject{
    func minusButtonAction(item: Coffee, count: UInt)
    func plusButtonAction(item: Coffee, count: UInt)
    func getItemImage(imageURL: String, completion: @escaping ((UIImage) -> Void))
}

class MenuListCell: UICollectionViewCell {
    //MARK: - Property
    static let identifier = String(describing: MenuListCell.self)
    weak var delegate: MenuListCellDelegate?
    var coffee: Coffee? {
        didSet {
            nameLabel.text = coffee?.name
            if let priceValue = coffee?.price {
                priceLabel.text = String(priceValue) + " руб"
            }
            guard let url = coffee?.imageURL else { return }
            delegate?.getItemImage(imageURL: url, completion: updateImageView(image:))
        }
    }
    var itemCount: UInt = 0 {
        didSet {
            countLabel.text = String(itemCount)
        }
    }
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownLight
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor.customBrownMedium
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var plusButton: PlusMinusButton = {
        let button = PlusMinusButton(buttonType: .plus)
        button.setTitleColor(UIColor.customBeige, for: .normal)
        button.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var minusButton: PlusMinusButton = {
        let button = PlusMinusButton(buttonType: .minus)
        button.setTitleColor(UIColor.customBeige, for: .normal)
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
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.customBrownLight
        return indicator
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents()
        setupLayout()
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemCount = 0
        nameLabel.text = ""
        priceLabel.text = ""
        countLabel.text = "\(itemCount)"
        activityIndicator.startAnimating()
    }

    //MARK: - Private functions
    private func configureComponents() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.customWhite
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 2
        contentView.layer.masksToBounds = false
    }
    
    private func setupLayout() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(plusButton)
        contentView.addSubview(countLabel)
        itemImageView.addSubview(activityIndicator)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 137),
            
            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            priceLabel.heightAnchor.constraint(equalToConstant: 17),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            
            plusButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            countLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 28),
            countLabel.heightAnchor.constraint(equalToConstant: 17),
            countLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
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
    
    private func updateImageView(image: UIImage) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.itemImageView.image = image
        }
    }
}
