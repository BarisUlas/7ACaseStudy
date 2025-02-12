//
//  UserListVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation
import UIKit

class UserListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let viewModel = UserListVM()
    private let tableView = UITableView()
    
    
    // pragma MARK: UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    // pragma MARK: -
    
    
    // pragma MARK: View Setup Methods
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    // pragma MARK: -
    
    
    // pragma MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.didReceiveUsers = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.loadUsers()
    }
    // pragma MARK: -
}
