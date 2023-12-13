//
//  ItemManager.swift
//  Todoey
//
//  Created by 권대윤 on 12/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ItemManager {
    
    static let shared = ItemManager()
    private init() {}
    
    
    //private lazy var itemArray: [Item] = []
    
    //private let defaults = UserDefaults.standard
    
    //데이터를 담을 plist 파일 경로(URL)를 담고 있는 프로퍼티
    private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let entityName = "Item"
    
    
    
    
//    func setupDataFromUserDefaults() {
//        loadItemsFromPlist()
//    }
//    
//    func getItem() -> [Item] {
//        return self.itemArray
//    }
//    
//    func isDone(index: Int, check: Bool) {
//        self.itemArray[index].done = check
//    }
//    
//    func createItem(text: String, completion: @escaping () -> Void) {
//        let newItem = Item(text: text)
//        self.itemArray.append(newItem)
//        
//        saveItemsInPlist()
//        
//        completion()
//    }
//    
//    func saveItemsInPlist() {
//        let encoder = PropertyListEncoder()
//        
//        do {
//            let data = try encoder.encode(self.itemArray)
//            
//            try data.write(to: dataFilePath!) //Items.plist 파일 생성
//            //print(dataFilePath)
//        } catch {
//            print("Error: encoding fail. \(error)")
//        }
//    }
//    
//    func loadItemsFromPlist() {
//        let decoder = PropertyListDecoder()
//        
//        do {
//            let data = try Data(contentsOf: dataFilePath!)
//            
//            self.itemArray = try decoder.decode([Item].self, from: data) //Items.plist에서 데이터 가져오기
//            
//        } catch {
//            print("Error: decoding fail. \(error)")
//        }
//    }
    
    
    
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽기
    func getItemsFromCoreData(category: Category?) -> [Item] {
        let name = category?.name ?? ""
        
        var toDoList: [Item] = []
        
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            //요청서에 검색 조건 설정
            request.predicate = NSPredicate(format: "parentCategory.name = %@", name as CVarArg)
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [Item] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return toDoList
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성
    func saveItemInCoreData(toDoText: String?, done: Bool, category: Category?, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? Item {
                    
                    toDoData.title = toDoText
                    toDoData.done = false
                    toDoData.parentCategory = category
                    
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: - [Update] 코어데이터에 데이터 수정
    func updateItemFromCoreData(item: Item, done: Bool) {
        guard let title = item.title else {return}
        
        if let context = self.context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "title = %@", title as CVarArg)
            do {
                if let fetchedToDoList = try context.fetch(request) as? [Item] {
                    if let target = fetchedToDoList.first {
                        target.done = done
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            } catch {
                print("update 실패")
            }
        }
    }
    
    
    //MARK: - [Delete] 코어데이터에 데이터 삭제
    func deleteItemFromCoreData(item: Item) {
        guard let title = item.title else {return}
        
        if let context = self.context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            request.predicate = NSPredicate(format: "title = %@", title as CVarArg)
            
            do {
                if let fetchedItemList = try context.fetch(request) as? [Item] {
                    if let target = fetchedItemList.first {
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
                print("delete 실패")
            }
        }
    }


    
}
