//
//  WebView.swift
//  HackerNews SwiftUI
//
//  Created by 권대윤 on 12/5/23.
//

import Foundation
import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> some UIView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let safeString = urlString else {
            return
        }
        
        guard let url = URL(string: safeString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        guard let uiView = uiView as? WKWebView else {
            return
        }
        
        uiView.load(request)
        
    }
    
    
}
