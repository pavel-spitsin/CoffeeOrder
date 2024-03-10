//
//  LocationService.swift
//  CoffeeOrder
//
//  Created by Pavel on 03.03.2024.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    //MARK: - Properties
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    //MARK: - Init
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        updateLocation()
    }
    
    //MARK: - Actions
    public func askUserForAuthorisation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func updateLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    public func currentLocationRequest(completion: (Double, Double) -> Void) {
        guard let currentLocation else {
            updateLocation()
            return
        }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        completion(lat, lon)
    }
    
    public func distanceRequest(coffeeShop: CoffeeShop, completion: (Double) -> Void) {
        guard let currentLocation else {
            updateLocation()
            return
        }
        
        guard let lat = Double(coffeeShop.point.latitude),
              let lon = Double(coffeeShop.point.longitude) else { return }
        
        let coordinate = CLLocation(latitude: lat, longitude: lon)
        let distance = coordinate.distance(from: currentLocation)/1000 //in km
        completion(distance)
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else { return }
        currentLocation = locValue
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
}
