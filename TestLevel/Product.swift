//
//  Product.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
}
