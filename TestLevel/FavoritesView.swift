//
//  FavoritesView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    @State private var searchText = ""

    var searchResults: [Product] {
        if searchText.isEmpty {
            return viewModel.favorites
        } else {
            return viewModel.favorites.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.favorites.isEmpty {
                    Text("Пока пусто")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(searchResults) { product in
                            VStack(alignment: .leading) {
                                Text(product.name).font(.headline)
                                Text(String(format: "%.2f грн", product.price)).foregroundColor(.green)
                            }
                        }
                        .onDelete(perform: removeFavorite)
                    }
                }
            }
            .navigationTitle("Обране")
            .searchable(text: $searchText, prompt: "Пошук в обраному")
        }
    }

    func removeFavorite(at offsets: IndexSet) {
        let productsToRemove = offsets.map { searchResults[$0] }
        for product in productsToRemove {
            viewModel.toggleFavorite(product)
        }
    }
}
