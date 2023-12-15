//
//  Item.swift
//  Todoey
//
//  Created by 권대윤 on 12/14/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String?
    @Persisted var done: Bool
    @Persisted var parentCategory: Category?
    
}


