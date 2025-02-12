//
//  UserListVM.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is the viewmodel for the UserListVC.
// Takes a userRepository to initalize and
// call the didReceiveUsers completion block.

import Foundation

class UserListVM {
    private let userRepository: UserRepositoryProtocol
    var users: [User] = []
    var didReceiveUsers: (() -> Void)?
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func loadUsers() {
        
        userRepository.fetchUsers { [weak self] result in
            
            // make sure to call it in main queue since we will
            // be doing UI updates.
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.didReceiveUsers?()
                case .failure(let error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }
        }
    }
}
