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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemManager.setupDataFromUserDefaults()
    }
    
   
    
    
    
    //MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.getItem().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemManager.getItem()[indexPath.row].text
        
        cell.accessoryType = itemManager.getItem()[indexPath.row].done == true ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            self.itemManager.isDone(index: indexPath.row, check: false)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.itemManager.isDone(index: indexPath.row, check: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemManager.saveItemsInPlist() //체크마크 변경사항을 plist 파일에 저장하기
    }
    
    
    //MARK: - Add New Items
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "새로운 할일 추가", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "새로운 할일"
            textField = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "할일 추가", style: .default, handler: { action in
            self.itemManager.createItem(text: textField.text!) {
                self.tableView.reloadData()
            }
        }))
        
        present(alert, animated: true)
    }
    
    
    
    
    
    
}



