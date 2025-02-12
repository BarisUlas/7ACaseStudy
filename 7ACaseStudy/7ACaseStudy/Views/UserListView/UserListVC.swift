//
//  UserListVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation
import UIKit

protocol UserListVCDelegate: AnyObject {
    func didSelectUser(_ user: User)
}

class UserListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let viewModel: UserListVM
    private let tableView = UITableView()
    weak var delegate: UserListVCDelegate?
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.users[indexPath.row]
        
        delegate?.didSelectUser(selectedUser)
        // Deselect the row after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // pragma MARK: -
    
    
    // pragma MARK: View Setup Methods
    private func setupNavigationTitle() {
        title = "Users"
    }
    
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    // pragma MARK: -
    
    
    // pragma MARK: View Lifecycle Methods
    
    init(viewModel: UserListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        setupTableView()
        viewModel.didReceiveUsers = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.loadUsers()
    }
    // pragma MARK: -
}
