//
//  CategoryManager.swift
//  Todoey
//
//  Created by 권대윤 on 12/13/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CategoryManager {
    
    static let shared = CategoryManager()
    private init() {}
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let entityName = "Category"
    
    
    func getCategorysFromCoreData() -> [Category] {
        var categoryList: [Category] = []
        
        if let context = self.context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            
            do {
                if let fetchedCategoryList = try context.fetch(request) as? [Category] {
                    categoryList = fetchedCategoryList
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return categoryList
    }
    
    
    func saveCategoryInCoreData(name: String?, completion: @escaping () -> Void) {
        if let context = self.context {
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                if let categoryData = NSManagedObject(entity: entity, insertInto: context) as? Category {
                    categoryData.name = name
                    categoryData.items
                    
                    do {
                        if context.hasChanges {
                            try context.save()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        completion()
    }
    
    
    func deleteCategoryFromCoreData(category: Category) {
        guard let name = category.name else {return}
        
        if let context = self.context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "name = %@", name as CVarArg)
            
            do {
                if let fetchedCategoryList = try context.fetch(request) as? [Category] {
                    if let target = fetchedCategoryList.first {
                        context.delete(target)
                        
                        do {
                            if context.hasChanges {
                                try context.save()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func updateCategoryFromCoreData(category: Category, name: String?) {
        guard let name = category.name else {return}
        
        if let context = self.context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "name = %@", name as CVarArg)
            
            do {
                if let fetchedCategoryList = try context.fetch(request) as? [Category] {
                    if let target = fetchedCategoryList.first {
                        target.name = name
                        
                        do {
                            if context.hasChanges {
                                try context.save()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
