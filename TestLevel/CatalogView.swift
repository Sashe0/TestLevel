//
//  CatalogView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    @State private var searchText = ""

    var searchResults: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            List(searchResults) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    VStack(alignment: .leading) {
                        Text(product.name).font(.headline)
                        Text(product.description).font(.subheadline).foregroundColor(.secondary)
                        Text(String(format: "%.2f грн", product.price)).font(.headline).foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Каталог")
            .searchable(text: $searchText, prompt: "Пошук товарів")
        }
    }
}
