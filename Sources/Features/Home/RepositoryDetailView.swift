//
//  RepositoryDetailView.swift
//
//
//  Created by Ryo Yoshitsugu on R 6/06/10.
//

import SwiftUI
import WebKit

struct RepositoryDetailView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    let repositoryUrl: String
    
    func makeUIView(context: Context) -> UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: repositoryUrl) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
