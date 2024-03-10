//
//  YBaseMapView.swift
//  CoffeeOrder
//
//  Created by Pavel on 29.02.2024.
//

import UIKit
import YandexMapsMobile

protocol YBaseMapViewProtocol: AnyObject {
    func showUserLocation(latitude: Double, longitude: Double)
    func setPlacemarks(for locations: [CoffeeShop])
}

class YBaseMapView: UIView {
    //MARK: - Property
    private var mapView = YMKMapView()
    var presenter: MapPresenterProtocol?

    //MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

//MARK: - Private functions
private extension YBaseMapView {
    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
    
    func setup() {
        // OpenGl is deprecated under M1 simulator, we should use Vulkan
        mapView = YMKMapView(frame: bounds, vulkanPreferred: YBaseMapView.isM1Simulator())
        mapView.mapWindow.map.mapType = .map
        self.addSubview(mapView)
    }

    func moveMapViewToLocation(latitude: Double, longitude: Double) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: YMKPoint(latitude: latitude, longitude: longitude), zoom: 9, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5),
            cameraCallback: nil
        )
    }
    
    func showCoffeeShopPlacemark(location: CoffeeShop) {
        guard let latitude = Double(location.point.latitude),
              let longitude = Double(location.point.longitude) else { return }
        let point = YMKPoint(latitude: latitude, longitude: longitude)
        let customPlacemark: YMKPlacemarkMapObject = mapView.mapWindow.map.mapObjects.addPlacemark()
        customPlacemark.userData = location
        customPlacemark.geometry = point
        let placemarkView = CoffeeShopPlacemarkView()
        customPlacemark.setViewWithView(YRTViewProvider(uiView: placemarkView))
        customPlacemark.addTapListener(with: self)
        customPlacemark.setTextWithText(
            location.name,
            style: YMKTextStyle(
                size: 14.0,
                color: UIColor.customBrownMedium,
                outlineColor: .clear,
                placement: .bottom,
                offset: 6.0,
                offsetFromIcon: true,
                textOptional: false
            )
        )
    }
}

//MARK: - YBaseMapViewProtocol
extension YBaseMapView: YBaseMapViewProtocol {
    func showUserLocation(latitude: Double, longitude: Double) {
        let point = YMKPoint(latitude: latitude, longitude: longitude)
        let viewPlacemark: YMKPlacemarkMapObject = mapView.mapWindow.map.mapObjects.addPlacemark()
        viewPlacemark.geometry = point
        viewPlacemark.setIconWith(
            UIImage(named: "location-indicator-red")!,
            style: YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 1.0) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1.5,
                tappableArea: nil
            )
        )
    }
    
    func setPlacemarks(for locations: [CoffeeShop]) {
        var lats = [Double]()
        var lons = [Double]()
        
        locations.forEach { location in
            guard let lat = Double(location.point.latitude),
                  let lon = Double(location.point.longitude) else { return }
            showCoffeeShopPlacemark(location: location)
            lats.append(lat)
            lons.append(lon)
        }
        
        let averageLat = lats.reduce(0, +)/Double(lats.count)
        let averageLon = lons.reduce(0, +)/Double(lons.count)
        moveMapViewToLocation(latitude: averageLat, longitude: averageLon)
    }
}

//MARK: - YMKMapObjectTapListener
extension YBaseMapView: YMKMapObjectTapListener{
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let placemark = mapObject as? YMKPlacemarkMapObject {
            if let location = placemark.userData as? CoffeeShop {
                presenter?.didSelectCoffeeShop(location: location)
            }
        }
        return true
    }
}
