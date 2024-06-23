//
//  ViewController.swift
//  test
//
//  Created by 권대윤 on 6/23/24.
//

import UIKit

struct Users: Codable {
    let name: String
}

class ViewController: UIViewController, UITableViewDataSource {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    
    var users: [Users] = []
    
    private let tableView: UITableView = {
      let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        Task {
            let result = await fetchUsers()
            switch result {
            case .success(let users):
                self.users = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    enum MyError: Error {
        case failedGetUsers
    }
    
    private func fetchUsers() async -> Result<[Users], Error> {
        guard let url = url else {
            return .failure(MyError.failedGetUsers)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try JSONDecoder().decode([Users].self, from: data)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

