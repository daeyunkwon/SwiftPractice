//
//  DetailView.swift
//  HackerNews SwiftUI
//
//  Created by 권대윤 on 12/5/23.
//

import SwiftUI


struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    DetailView(url: "https://www.naver.com")
}



