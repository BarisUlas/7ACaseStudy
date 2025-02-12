//
//  UserListVM.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

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
