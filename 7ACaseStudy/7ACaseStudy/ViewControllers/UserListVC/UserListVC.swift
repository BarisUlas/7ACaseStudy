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

class UserListVC: UIViewController  {

    let viewModel: UserListVM
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let loadingText = UILabel()
    weak var delegate: UserListVCDelegate?
    
    
    // pragma MARK: View Setup Methods
    private func setupNavigationTitle() {
        title = NSLocalizedString("USERS_STRING", comment: "")
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        //tableView.frame = view.bounds
        tableView.clipsToBounds = true
    }
    
    private func hideLoadingView() {
        loadingIndicator.stopAnimating()
        loadingText.isHidden = true
    }
    
    private func showLoadingView() {
        loadingIndicator.startAnimating()
        loadingText.isHidden = false
    }
    
    private func setupLoadingView() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        loadingText.text = NSLocalizedString("LOADING_STRING", comment: "")
            .uppercased()
        loadingText.alpha = 0.8
        loadingText.font = .systemFont(ofSize: 12, weight: .light)
        loadingText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingText)
        
        NSLayoutConstraint.activate([
            loadingIndicator.widthAnchor.constraint(equalToConstant: 30),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 30),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loadingText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingText.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 12)
        ])
        
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
        
        self.view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        
        setupNavigationTitle()
        setupTableView()
        setupLoadingView()
        showLoadingView()
        viewModel.didReceiveUsers = { [weak self] in
            self?.hideLoadingView()
            self?.tableView.reloadData()
        }
        
        viewModel.loadUsers()
    }
    // pragma MARK: -
}
