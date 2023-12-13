//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemManager = ItemManager.shared
    
    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedCategory: Category? {
        didSet {
            //tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        items = itemManager.getItemsFromCoreData(category: self.selectedCategory)
        
    }
    
   
    
    
    
    //MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].title
        
        cell.accessoryType = items[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            let selectItem = items[indexPath.row]
            itemManager.updateItemFromCoreData(item: selectItem, done: false)
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            let selectItem = items[indexPath.row]
            itemManager.updateItemFromCoreData(item: selectItem, done: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK: - Add New Items
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "새로운 할일 추가", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "새로운 할일"
            textField = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "추가", style: .default, handler: { action in
            self.itemManager.saveItemInCoreData(toDoText: textField.text, done: false, category: self.selectedCategory) {
                self.items = self.itemManager.getItemsFromCoreData(category: self.selectedCategory)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
  
    
    
}


//MARK: - UISearchBarDelegate
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText != "" else {
            searchBar.resignFirstResponder()
            return
        }
        
        let itemList = itemManager.getItemsFromCoreData(category: self.selectedCategory)
        
        let searchItems = itemList.filter { item in
            //String을 Character로 변경한다
            //한 단어씩 비교한다
            //단어 갯수&단어 위치에 맞게 비교한다
            
            guard let string = item.title else {return false}
            
            var searchLetter: [Character] = []
            
            var titleLetter: [Character] = []
            
            var excuteCount: Int = 0
            
            
            for character in searchText {
                searchLetter.append(character)
            }
            
            for character in string {
                titleLetter.append(character)
            }
            
            if searchLetter.count > titleLetter.count {
                excuteCount = titleLetter.count
            } else if searchLetter.count == titleLetter.count {
                excuteCount = searchLetter.count
            } else {
                excuteCount = searchLetter.count
            }
            
            for i in 0..<excuteCount {
                if titleLetter[i] == searchLetter[i] {
                    if titleLetter[excuteCount-1] != searchLetter.last {
                        return false
                    }
                    return true
                } else {
                    return false
                }
            }
            return false
        }
        
        items = searchItems
        searchBar.searchTextField.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.items = self.itemManager.getItemsFromCoreData(category: self.selectedCategory)
        }
    }
    
}



