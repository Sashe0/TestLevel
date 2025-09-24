//
//  CartView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ShopViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cart.isEmpty {
                    Text("Кошик порожній")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(viewModel.cart.keys.sorted(by: { $0.name < $1.name }), id: \.self) { product in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.name).font(.headline)
                                    Text(String(format: "%.2f грн", product.price))
                                }
                                Spacer()
                                HStack {
                                    Button(action: { viewModel.removeFromCart(product) }) {
                                        Image(systemName: "minus.circle")
                                    }
                                    Text("\(viewModel.cart[product] ?? 0)")
                                        .frame(minWidth: 30)
                                    Button(action: { viewModel.addToCart(product) }) {
                                        Image(systemName: "plus.circle")
                                    }
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    
                    Text(String(format: "Загальна сума: %.2f грн", viewModel.totalCartPrice))
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .navigationTitle("Кошик")
            .toolbar {
                if !viewModel.cart.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Очистити кошик") {
                            viewModel.clearCart()
                        }
                    }
                }
            }
        }
    }
}
