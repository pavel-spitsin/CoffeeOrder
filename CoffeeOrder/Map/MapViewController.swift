//
//  MapViewController.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024
//

import UIKit
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
    func showUserLocation(latitude: Double, longitude: Double)
}

class MapViewController: UIViewController {
    //MARK: - Property
    var presenter: MapPresenterProtocol?
    var locations: [CoffeeShop]
    private lazy var mapView: YBaseMapView = {
        let map = YBaseMapView(frame: view.bounds)
        map.presenter = presenter
        return map
    }()
    
    //MARK: - Init
    init(locations: [CoffeeShop]) {
        self.locations = locations
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Карта"
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getUserLocation()
        mapView.setPlacemarks(for: locations)
    }
}

//MARK: - Private functions
private extension MapViewController {
    func initialize() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {
    func showUserLocation(latitude: Double, longitude: Double) {
        mapView.showUserLocation(latitude: latitude, longitude: longitude)
    }
}
