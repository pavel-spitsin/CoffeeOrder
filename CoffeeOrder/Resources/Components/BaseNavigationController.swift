//
//  BaseNavigationController.swift
//  CoffeeOrder
//
//  Created by Pavel on 08.02.2024.
//

import UIKit

class BaseNavigationController : UINavigationController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.customBrownMedium,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        navigationBarAppearance.backgroundColor = UIColor.navBarBackground
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = UIColor.customBrownMedium
        addCustomBottomLine(color: UIColor.navBarBorder, height: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}
