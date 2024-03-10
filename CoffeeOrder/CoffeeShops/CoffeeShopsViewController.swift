//
//  CoffeeShopsViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 12.02.2024
//

import UIKit

protocol CoffeeShopsViewProtocol: AnyObject {
    func showLocations(locations: [CoffeeShop])
}

class CoffeeShopsViewController: BaseViewController {
    //MARK: - Property
    var presenter: CoffeeShopsPresenterProtocol?
    private var locations: [CoffeeShop]? {
        didSet {
            if locations?.isEmpty == false {
                toMapButton.isActive = true
            }
        }
    }
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoffeeShopListCell.self, forCellReuseIdentifier: "CoffeeShopListCell")
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 50, right: 0)
        return tableView
    }()
    private lazy var toMapButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "На карте", isActive: false)
        button.addTarget(self, action: #selector(toMapButtonAction), for: .touchUpInside)
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
        navigationItem.title = "Ближайший кофейни"
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        presenter?.viewDidAppear()
    }
}

//MARK: - Private functions
private extension CoffeeShopsViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(toMapButton)
        view.addSubview(activityIndicator)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        toMapButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toMapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toMapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toMapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func toMapButtonAction() {
        guard let locations else { return }
        presenter?.toMapButtonTapped(locations: locations)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

//MARK: - CoffeeShopsViewProtocol
extension CoffeeShopsViewController: CoffeeShopsViewProtocol {
    func showLocations(locations: [CoffeeShop]) {
        DispatchQueue.main.async {
            self.locations = locations
            self.tableView.reloadData()
            self.stopActivityIndicator()
        }
    }
}

//MARK: - UITableViewDataSource
extension CoffeeShopsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeShopListCell.identifier, for: indexPath) as? CoffeeShopListCell else {
            return UITableViewCell()
        }
        cell.delegate = presenter as? any CoffeeShopListCellDelegate
        cell.location = locations?[indexPath.item]
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CoffeeShopsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath.item)
    }
}
