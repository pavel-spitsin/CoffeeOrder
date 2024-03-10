//
//  CoffeeShopPlacemarkView.swift
//  CoffeeOrder
//
//  Created by Pavel on 05.03.2024.
//

import UIKit

class CoffeeShopPlacemarkView: UIImageView {
    //MARK: - Init
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        backgroundColor = UIColor.customBrownDark
        layer.cornerRadius = 58/2
        let image = UIImage(named: "Cup_svg")?.withTintColor(UIColor.customBeige)

        if let smallImage = image {
            let resizedImage = smallImage.resized(to: CGSize(width: 24, height: 24))
            self.image = resizedImage
            contentMode = .center
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
