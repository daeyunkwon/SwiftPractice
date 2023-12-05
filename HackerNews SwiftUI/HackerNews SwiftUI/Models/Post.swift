//
//  Post.swift
//  HackerNews SwiftUI
//
//  Created by 권대윤 on 12/1/23.
//

import Foundation
import UIKit

struct Results: Codable {
    let hits: [Post]
}

//Identifiable 프로토콜을 채택하면 id라는 속성을 꼭 추가해줘야 한다!
struct Post: Codable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?

    
}






