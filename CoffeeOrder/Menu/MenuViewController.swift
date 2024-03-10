//
//  MenuViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 17.02.2024
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    func showMenu(menu: [Coffee])
}

class MenuViewController: BaseViewController {
    //MARK: - Property
    var presenter: MenuPresenterProtocol?
    private var menu: [Coffee]?
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuListCell.self, forCellWithReuseIdentifier: "MenuListCell")
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    private lazy var toCheckoutButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "Перейти к оплате")
        button.addTarget(self, action: #selector(toCheckoutButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.customBrownLight
        return indicator
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Меню"
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        presenter?.viewDidAppear()
    }
}

//MARK: - Private functions
private extension MenuViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(toCheckoutButton)
        view.addSubview(activityIndicator)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toCheckoutButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toCheckoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toCheckoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toCheckoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func toCheckoutButtonAction() {
        presenter?.toOrderTapped()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

//MARK: - MenuViewProtocol
extension MenuViewController: MenuViewProtocol {
    func showMenu(menu: [Coffee]) {
        DispatchQueue.main.async {
            self.menu = menu
            self.collectionView.reloadData()
            self.stopActivityIndicator()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuListCell.identifier,
                                                            for: indexPath) as? MenuListCell else { return UICollectionViewCell() }
        cell.delegate = presenter as? any MenuListCellDelegate
        if let menu {
            cell.coffee = menu[indexPath.item]
        }
        if let order = presenter?.checkOrder(), let coffee = cell.coffee {
            cell.itemCount = order[coffee] ?? 0
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 17, left: 16, bottom: 50, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetsSum = 16.0 + 16.0 + 13.0
        let itemWidth = collectionView.frame.width/2.0 - insetsSum/2.0
        return CGSize(width: itemWidth, height: 205)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
}
