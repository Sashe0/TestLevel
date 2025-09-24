//
//  ContentView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ShopViewModel()
    @AppStorage("colorScheme") private var colorScheme: Int = 0 // 0: System, 1: Light, 2: Dark

    var body: some View {
        TabView {
            CatalogView()
                .tabItem {
                    Label("Каталог", systemImage: "list.bullet")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Обране", systemImage: "star.fill")
                }
            
            CartView()
                .tabItem {
                    Label("Кошик", systemImage: "cart.fill")
                }
            
            BrowserView()
                .tabItem {
                    Label("Браузер", systemImage: "globe")
                }

            SettingsView()
                .tabItem {
                    Label("Налаштування", systemImage: "gear")
                }
        }
        .environmentObject(viewModel)
        .preferredColorScheme(colorScheme == 1 ? .light : colorScheme == 2 ? .dark : nil)
    }
}

#Preview {
    ContentView()
}
