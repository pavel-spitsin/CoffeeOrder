//
//  TokenHolder.swift
//  CoffeeOrder
//
//  Created by Pavel on 16.02.2024.
//

final class TokenHolder {
    //MARK: - Property
    static let shared = TokenHolder()
    var token: String?

    //MARK: - Init
    private init() {}
}
