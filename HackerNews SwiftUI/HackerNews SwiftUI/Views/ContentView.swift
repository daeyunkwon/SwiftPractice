//
//  ContentView.swift
//  HackerNews SwiftUI
//
//  Created by 권대윤 on 12/1/23.
//

import SwiftUI

struct ContentView: View {
    //@Published 속성에 변경사항이 있을 때마다 뷰를 갱신함
    @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
                
            }
            .navigationTitle("HACKER NEWS")
            let _ = print("navi completion")
        }
        .onAppear {
            self.networkManager.fetchData()
            let _ = print("on Appear")
        }
    }
    
    
    
    
}

#Preview {
    ContentView()
}




