//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by 권대윤 on 12/13/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var done: Bool
    @NSManaged public var title: String?
    @NSManaged public var parentCategory: Category?

}

extension Item : Identifiable {

}
