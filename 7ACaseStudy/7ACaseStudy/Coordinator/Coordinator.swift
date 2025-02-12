//
//  Coordinator.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation
import UIKit

class Coordinator: UserListVCDelegate {
    
    func didSelectUser(_ user: User) {
        print("coordinator got \(user.name)")
    }
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userListVM = UserListVM()
        let userListVC = UserListVC(viewModel: userListVM)
        userListVC.delegate = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([userListVC], animated: true)
        
    }
    
    func showUserDetail(for user: User) {
    }
}
