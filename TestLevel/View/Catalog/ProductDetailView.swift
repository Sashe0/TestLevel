//
//  ProductDetailView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
            Text(product.name)
                .font(.largeTitle)
            Text(product.description)
                .font(.body)
                .padding()
            Text(String(format: "Ціна: %.2f грн", product.price))
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()

            Button(action: {
                viewModel.toggleFavorite(product)
            }) {
                Label(viewModel.isFavorite(product) ? "В обраному" : "В обране",
                      systemImage: viewModel.isFavorite(product) ? "star.fill" : "star")
            }
            .padding()
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button(action: {
                viewModel.addToCart(product)
            }) {
                Label("В кошик", systemImage: "cart.badge.plus")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
