//
//  AppDelegate.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Property
    var window: UIWindow?

    //MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0) //Just to show LaunchScreen for 1 second
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = StartModuleBuilder.build()
        let navigationController = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        LocationService().askUserForAuthorisation()
        YMKMapKit.setApiKey(YandexMapKitApiKey.apiKey) //HINT BELOW
        YMKMapKit.setLocale("ru_RU")
        YMKMapKit.sharedInstance()
        return true
    }
}

//MARK: - To run the application, you need to add the YandexMapKitApiKey structure to the API folder
/*
 struct YandexMapKitApiKey {
     static let apiKey = "YOUR_API_KEY"
 }
*/
