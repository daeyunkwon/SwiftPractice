//
//  Category.swift
//  Todoey
//
//  Created by 권대윤 on 12/14/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String?
    //let items = List<Item>()
    let items: List<Item>? = nil
}
