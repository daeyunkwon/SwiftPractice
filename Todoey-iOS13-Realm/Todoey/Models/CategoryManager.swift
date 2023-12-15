//
//  CategoryManager.swift
//  Todoey
//
//  Created by 권대윤 on 12/13/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryManager {
    
    static let shared = CategoryManager()
    private init() {}
    
    let realm = try! Realm()
    
    
    
    
    func getCategorysFromRealm() -> [Category] {
        var categoryArray: [Category] = []
        
        do {
            try realm.write {
                let categorys = realm.objects(Category.self)
                
                categorys.forEach({ category in
                    categoryArray.append(category)
                })
                
            }
        } catch {
            print("\(#function) failed")
        }
        
        return categoryArray
    }
    
    
    func saveCategoryInRealm(name: String?, completion: @escaping () -> Void) {
        let category = Category()
        category.name = name
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("\(#function) failed")
        }
        
        completion()
    }
    
    
    func deleteCategoryFromRealm(category: Category) {
        guard let name = category.name else {return}
        
        do {
            try realm.write {
                let categorys = realm.objects(Category.self)
                let target = categorys.where {
                    $0.name == name
                }
                realm.delete(target)
            }
        } catch {
            print("\(#function) failed")
        }
    }
    
    
    
    func updateCategoryFromRealm(category: Category, name: String?) {
        guard let name = category.name else {return}
        
        do {
            try realm.write {
                let categorys = realm.objects(Category.self)
                let target = categorys.where {
                    $0.name == name
                }
                
                target.first?.name = name
                
            }
        } catch {
            print("\(#function) failed")
        }
    }
    
    
    
}


