//
//  UserDetailVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is the VC that shows the User Details when
// tapped from the List in UserListVC

import UIKit

class UserDetailVC: UIViewController {
    
    private let stackView = UIStackView()
    private var user: User?
    private var viewModel: UserDetailVM
    
    private func setupStackView() {
        
        // I have decided to use a vertical stack view to
        // effortlessly place my custom CustomSegmentView
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // center it horizontally while leaving a bit of space
        // from top, left and right.
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
    }
    
    private func setupSegmentView(withHeadline headline: String, withContent content: String) {
        // this is the custom view that I've decided to use for this project.
        // it just displays the content headline and the actual content itself
        // inside of a rounded gray rectangle, just like the one used in
        // phone app in iOS.
        let segmentView = CustomSegmentView(withHeadlineString: headline, withContentString: content)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.addArrangedSubview(segmentView)
    }
    
    private func placeSegmentViews() {
        
        // helper method to place the required fields inside the
        // vertical stack view.
        setupSegmentView(
            withHeadline: viewModel.emailHeadline,
            withContent:  viewModel.emailContent
        )
        setupSegmentView(
            withHeadline: viewModel.phoneHeadline,
            withContent:  viewModel.phoneContent
        )
        setupSegmentView(
            withHeadline: viewModel.websiteHeadline,
            withContent:  viewModel.websiteContent
        )
    }
    
    private func setupNavigationTitle() {
        // show the user name by making it the title of
        // the navigation controller.
        title = viewModel.name
    }
    
    init(viewModel: UserDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set a color based on the user's UI style
        self.view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        
        setupNavigationTitle()
        setupStackView()
        placeSegmentViews()
    }
}
