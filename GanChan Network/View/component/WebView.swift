//
//  WebView.swift
//  GanChan Network
//
//  Created by 高橋龍一 on 2023/05/24.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            
            if uiView.url != url {
                uiView.load(request)
            }
        }
    }

}

