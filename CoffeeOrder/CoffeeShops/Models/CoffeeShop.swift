//
//  CoffeeShop.swift
//  CoffeeOrder
//
//  Created by Pavel on 16.02.2024.
//

struct CoffeeShop: Codable {
    let id: Int
    let name: String
    let point: Point
}

struct Point: Codable {
    let latitude: String
    let longitude: String
}
