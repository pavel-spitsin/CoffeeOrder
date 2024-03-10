//
//  OrderViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 20.02.2024
//

import UIKit
import AVFoundation

protocol OrderViewProtocol: AnyObject {
    func showOrder(order: [Coffee : UInt]?)
    func payButtonErrorAnimation()
    func showDeliveryTimeAlert()
}

class OrderViewController: BaseViewController {
    //MARK: - Property
    var presenter: OrderPresenterProtocol?
    private var locations: [CoffeeShop]?
    private var order: [Coffee : UInt]?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(OrderListCell.self, forCellReuseIdentifier: "OrderListCell")
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 50, right: 0)
        return tableView
    }()
    private lazy var payButton: DialogButton = {
        let button = DialogButton(buttonType: .close, title: "Оплатить")
        button.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var deliveryTimeAlert: UIAlertController = {
        let title = """
                    Время ожидания заказа
                    15 минут!
                    Спасибо, что выбрали нас!
                    """
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium),
            NSAttributedString.Key.foregroundColor : UIColor.customBrownMedium
        ])
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor.customWhite
        return alert
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ваш заказ"
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}

//MARK: - Private functions
private extension OrderViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(payButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
        ])
    }
    
    @objc func payButtonAction() {
        presenter?.payButtonTapped()
    }
}

//MARK: - OrderViewProtocol
extension OrderViewController: OrderViewProtocol {
    func showOrder(order: [Coffee : UInt]?) {
        DispatchQueue.main.async {
            self.order = order
            self.tableView.reloadData()
        }
    }
    
    func payButtonErrorAnimation() {
        payButton.errorShakeAnimation()
    }
    
    func showDeliveryTimeAlert() {
        UIView.animate(withDuration: 0.3) {
            self.present(self.deliveryTimeAlert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.deliveryTimeAlert.dismiss(animated: true) {
                        self.presenter?.deliveryTimeAlertShowed()
                    }
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderListCell.identifier, for: indexPath) as? OrderListCell else {
            return UITableViewCell()
        }
        cell.delegate = presenter as? any OrderListCellDelegate
        if let order {
            let orderKeys = order.keys.sorted(by: {$0.id < $1.id})
            let coffee = orderKeys[indexPath.item]
            cell.coffee = coffee
            cell.itemCount = order[coffee] ?? 0
        }
        return cell
    }
}
