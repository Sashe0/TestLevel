//
//  SettingsView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("colorScheme") private var colorScheme: Int = 0 // 0: System, 1: Light, 2: Dark
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Тема")) {
                    Picker("Оберіть тему", selection: $colorScheme) {
                        Text("Системна").tag(0)
                        Text("Світла").tag(1)
                        Text("Темна").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Налаштування")
        }
    }
}