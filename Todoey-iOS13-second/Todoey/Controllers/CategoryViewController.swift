//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 권대윤 on 12/13/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    let categoryManager = CategoryManager.shared
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryManager.getCategorysFromCoreData().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryManager.getCategorysFromCoreData()[indexPath.row].name
        
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let toDoListVC = segue.destination as? ToDoListViewController else {
            return
        }
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            print("인덱스 경로를 가져오기 실패")
            return
        }
        
        toDoListVC.selectedCategory = categoryManager.getCategorysFromCoreData()[indexPath.row]
    }
    

    //MARK: - Add new Category
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "새로운 카테고리 생성", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "카테고리 이름"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { okAction in
            guard let text = alert.textFields?.first?.text else {return}
            
            self.categoryManager.saveCategoryInCoreData(name: text) {
                self.tableView.reloadData()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { cancelAction in
            print("cancel")
        }))
        
        present(alert, animated: true)
        
    }
    

    

}
