//
//  Item.swift
//  Todoey
//
//  Created by 권대윤 on 12/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct Item: Codable {
    let text: String
    var done: Bool = false
}
