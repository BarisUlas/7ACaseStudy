//
//  Coordinator.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//


// Coordinator is responsible from navigating to/from
// UserList VC and UserDetail VC

// we initialize it with a new instance of
// UINavigationController and call start() method
// from SceneDelegate to push our initial VC: UserListVC

import Foundation
import UIKit

class Coordinator: UserListVCDelegate {
    
    func didSelectUser(_ user: User) {
        condPrint("coordinator got \(user.name)")
        showUserDetail(for: user)
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
        let userDetailVM = UserDetailVM(user: user)
        let userDetailVC = UserDetailVC(viewModel: userDetailVM)
        navigationController.pushViewController(userDetailVC, animated: true)
    }
}
