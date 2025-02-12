//
//  UserTableVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is the same UserList VC, just made as an extension
// to add the tableview delegate methods.

// It could be done in the same file, but seperating it
// makes the codebase a lot cleaner

import UIKit

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    
    // Just the implementations of the UITableViewDelegate and
    // UITableViewDataSource protocols.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // we need to return a row for every user in the array
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create the cell to show the username and email
        // we can use .subtitle style to
        // wrap them automatically in a vertical stack
        
        // Also use .disclosureIndicator accessoryType
        // to get the little "chevron.right" at the end
        // of our cell. Makes it look better.
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when we select a user, let the delegate know in order to
        // pass the info to Coordinator to push the UserDetailVC
        
        let selectedUser = viewModel.users[indexPath.row]
        delegate?.didSelectUser(selectedUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
