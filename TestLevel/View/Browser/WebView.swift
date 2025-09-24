//
//  WebView.swift
//  TestLevel
//
//  Created by Саша Боднар on 24.09.2025.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var error: Error?
    let webView: WKWebView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            parent.error = nil
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.error = error
        }
    }
}

struct BrowserView: View {
    @State private var showBrowser = false
    
    var body: some View {
        VStack {
            Button("Відкрити Google") {
                showBrowser.toggle()
            }
        }
        .sheet(isPresented: $showBrowser) {
            NavigationView {
                BrowserContentView(showBrowser: $showBrowser)
            }
        }
    }
}

struct BrowserContentView: View {
    @State private var isLoading = true
    @State private var error: Error?
    @Binding var showBrowser: Bool
    
    private let webView: WebView
    
    init(showBrowser: Binding<Bool>) {
        _showBrowser = showBrowser
        let isLoadingState = State(initialValue: true)
        let errorState = State<Error?>(initialValue: nil)
        
        self.webView = WebView(
            url: URL(string: "https://www.google.com")!,
            isLoading: .init(get: { isLoadingState.wrappedValue }, set: { isLoadingState.wrappedValue = $0 }),
            error: .init(get: { errorState.wrappedValue }, set: { errorState.wrappedValue = $0 })
        )

        _isLoading = isLoadingState
        _error = errorState
    }

    var body: some View {
        VStack {
            webView
                .overlay(
                    Group {
                        if isLoading {
                            ProgressView("Завантаження...")
                        } else if let error = error {
                            VStack(spacing: 10) {
                                Text("Не вдалося завантажити")
                                    .font(.headline)
                                Text(error.localizedDescription)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Button("Повторити") {
                                    self.webView.webView.reload()
                                }
                                .padding(.top)
                            }
                        }
                    }
                )

            HStack {
                Button(action: { webView.webView.goBack() }) { Image(systemName: "chevron.left") }
                Spacer()
                Button(action: { webView.webView.goForward() }) { Image(systemName: "chevron.right") }
                Spacer()
                Button(action: { webView.webView.reload() }) { Image(systemName: "arrow.clockwise") }
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .navigationTitle("Google")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Закрити") { showBrowser = false }
            }
        }
    }
}
