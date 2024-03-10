//
//  CoffeeShopService.swift
//  CoffeeOrder
//
//  Created by Pavel on 09.02.2024.
//

import Foundation
import UIKit

class CoffeeShopService {
    //MARK: - Actions
    func userRegistration(email: String, password: String, completion: (() -> Void)?) {
        guard let url = URL(string: "http://147.78.66.203:3210/auth/register") else { return }
        let parameters = ["login": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data, !data.isEmpty, let completion {
                print(data)
                completion()
            }
        }.resume()
    }
    
    func userEnter(email: String, password: String, completion: (() -> Void)?) {
        guard let url = URL(string: "http://147.78.66.203:3210/auth/login") else { return }
        let parameters = ["login": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                if let json = json as? [String: Any], let token = json["token"] as? String {
                    TokenHolder.shared.token = token
                    guard let completion else { return }
                    completion()
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    func getLocations(completion: @escaping ([CoffeeShop]) -> Void) {
        guard let token = TokenHolder.shared.token else { return }
        guard let url = URL(string: "http://147.78.66.203:3210/locations") else { return }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data else { return }
            do {
                let coffeeShops = try JSONDecoder().decode([CoffeeShop].self, from: data)
                completion(coffeeShops)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func getLocationMenu(locationID: Int, completion: @escaping ([Coffee]) -> Void) {
        guard let token = TokenHolder.shared.token else { return }
        guard let url = URL(string: "http://147.78.66.203:3210/location/\(locationID)/menu") else { return }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data else { return }
            do {
                let menu = try JSONDecoder().decode([Coffee].self, from: data)
                completion(menu)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func loadImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data, let image = UIImage(data: data) else {
                print("Couldn't load image")
                return
            }
            completion(image)
        }).resume()
    }
}
