//
//  UserListVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is our initial ViewController (VC). It will be
// used to display the users in tableview

import Foundation
import UIKit

// create a delegate method to pass the user object to
// coordinator to make it switch to the detail VC with
// the given User object.
protocol UserListVCDelegate: AnyObject {
    func didSelectUser(_ user: User)
}

class UserListVC: UIViewController  {

    let viewModel: UserListVM
    let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let loadingText = UILabel()
    
    // make sure the delegate is weak
    // we don't want to cause a retain cycles
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
        
        // make the tableview as long and as wide as the current window
        // also make sure to respect the safe areas in order to not overlap
        // with system UI elements
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    // method to hide the spinner and its label
    private func hideLoadingView() {
        loadingIndicator.stopAnimating()
        loadingText.isHidden = true
    }
    
    // method to show the spinner and its label
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
        
        
        // position the spinner at the center
        // and the label right below it
        
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
        
        // make sure to set a background color depending
        // on the user's ui style.
        // not specifying a color causes visual bugs with
        // navigation push/pop operations.
        self.view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        
        setupNavigationTitle()
        setupTableView()
        setupLoadingView()
        showLoadingView()
        
        viewModel.didReceiveUsers = { [weak self] in
            // we have received users, it is now time to
            // hide the loading view and reload the tableview
            self?.hideLoadingView()
            self?.tableView.reloadData()
        }
        
        // make the request
        viewModel.loadUsers()
    }
    // pragma MARK: -
}
