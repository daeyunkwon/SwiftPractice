//
//  NetworkManager.swift
//  HackerNews SwiftUI
//
//  Created by 권대윤 on 12/1/23.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let safeData = data else {
                    print("Error: data")
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(Results.self, from: safeData)
                    DispatchQueue.main.async {
                        self.posts = results.hits
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                
            }
            task.resume()
        }
    }
    
    
    
    
    
}
