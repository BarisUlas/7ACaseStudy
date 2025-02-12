//
//  UserListVM.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation

class UserListVM {
    var users: [User] = []
    var didReceiveUsers: (() -> Void)?
    
    func loadUsers() {
        NetworkManager.shared.fetchUsers { [weak self] users in
            guard let self = self else { return }
            guard let users = users else { return }
            
            self.users = users
            
            // notify the view on main queue
            DispatchQueue.main.async {
                self.didReceiveUsers?()
            }
        }
    }
}
