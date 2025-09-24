//
//  ShopViewModel.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import Foundation
import Combine

class ShopViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var favorites: [Product] = []
    @Published var cart: [Product: Int] = [:] // [Товар: Кількість]

    init() {
        products = (1...20).map { i in
            Product(name: "Товар \(i)",
                    description: "Це опис для товару під номером \(i).",
                    price: Double.random(in: 100...2000))
        }
    }

    // MARK: - Favorites
    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(where: { $0.id == product.id })
    }

    func toggleFavorite(_ product: Product) {
        if isFavorite(product) {
            favorites.removeAll(where: { $0.id == product.id })
        } else {
            favorites.append(product)
        }
    }

    // MARK: - Cart
    func addToCart(_ product: Product) {
        cart[product, default: 0] += 1
    }

    func removeFromCart(_ product: Product) {
        if let count = cart[product], count > 1 {
            cart[product] = count - 1
        } else {
            cart.removeValue(forKey: product)
        }
    }
    
    func clearCart() {
        cart.removeAll()
    }

    var totalCartPrice: Double {
        cart.reduce(0) { total, item in
            total + (item.key.price * Double(item.value))
        }
    }
}
