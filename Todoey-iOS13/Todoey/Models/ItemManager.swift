//
//  ItemManager.swift
//  Todoey
//
//  Created by 권대윤 on 12/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

class ItemManager {
    
    static let shared = ItemManager()
    private init() {}
    
    
    private lazy var itemArray: [Item] = []
    
    private let defaults = UserDefaults.standard
    
    //데이터를 담을 plist 파일 경로(URL)를 담고 있는 프로퍼티
    private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    
    func setupDataFromUserDefaults() {
        loadItemsFromPlist()
    }
    
    func getItem() -> [Item] {
        return self.itemArray
    }
    
    func isDone(index: Int, check: Bool) {
        self.itemArray[index].done = check
    }
    
    func createItem(text: String, completion: @escaping () -> Void) {
        let newItem = Item(text: text)
        self.itemArray.append(newItem)
        
        saveItemsInPlist()
        
        completion()
    }
    
    func saveItemsInPlist() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            
            try data.write(to: dataFilePath!) //Items.plist 파일 생성
            //print(dataFilePath)
        } catch {
            print("Error: encoding fail. \(error)")
        }
    }
    
    func loadItemsFromPlist() {
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: dataFilePath!)
            
            self.itemArray = try decoder.decode([Item].self, from: data) //Items.plist에서
            
        } catch {
            print("Error: decoding fail. \(error)")
        }
    }
    
    
    
    
    
}
