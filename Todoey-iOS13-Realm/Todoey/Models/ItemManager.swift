//
//  ItemManager.swift
//  Todoey
//
//  Created by 권대윤 on 12/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class ItemManager {
    
    static let shared = ItemManager()
    private init() {}
    
    let realm = try! Realm()
    
    
    
    
    

    func getItemsFromRealm(category: Category?) -> [Item] {
        guard let category = category else {
            print("\(#function) guard문 else return.")
            return [Item]()
        }
        
        var itemArray: [Item] = []
        
        do {
            try realm.write {
                let items = realm.objects(Item.self)
                let itemsFitTheCategory = items.where({
                    $0.parentCategory == category
                })
                
                itemsFitTheCategory.forEach { item in
                    itemArray.append(item)
                }
                
            }
        } catch {
            print("\(#function) failed.")
        }
        
        return itemArray
    }
    
    
    func saveItemInRealm(toDoText: String?, done: Bool, category: Category?, completion: @escaping () -> Void) {
        
        do {
            try realm.write {
                let item = Item()
                
                item.title = toDoText
                item.done = done
                item.parentCategory = category
                
                realm.add(item)
            }
        } catch {
            print("\(#function) failed.")
        }
        completion()
    }
    
    
    func updateItemFromRealm(item: Item, done: Bool, category: Category?) {
        guard let title = item.title else {return}
        
        guard let category = category else {
            print("\(#function) guard문 else return.")
            return
        }
        
        do {
            try realm.write {
                let items = realm.objects(Item.self)
                
                let itemsFitTheCategory = items.where {
                    $0.parentCategory == category
                }
                
                let itemsFitTheTitle = itemsFitTheCategory.where {
                    $0.title == title
                }
                
                if let target = itemsFitTheTitle.first {
                    target.done = done
                }
                
            }
        } catch {
            print("\(#function) failed.")
        }
    }
    
    
    func deleteItemFromRealm(item: Item) {
        guard let title = item.title else {return}
        
        do {
            try realm.write {
                let items = realm.objects(Item.self)
                
                let itemsFitTheTitle = items.where {
                    $0.title == title
                }
                
                if let target = itemsFitTheTitle.first {
                    realm.delete(target)
                }
                
            }
        } catch {
            print("\(#function) failed.")
        }
    }


    
}

