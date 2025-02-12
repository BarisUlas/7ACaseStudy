//
//  UserDetailVC.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import UIKit

class UserDetailVC: UIViewController {
    
    private let stackView = UIStackView()
    private var user: User?
    
    private func setupStackView() {
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
    }
    
    private func setupSegmentView(withHeadline headline: String, withContent content: String) {
        let segmentView = CustomSegmentView(withHeadlineString: headline, withContentString: content)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.addArrangedSubview(segmentView)
    }
    
    private func placeSegmentViews() {
        guard let user = user else { return }
        
        setupSegmentView(
            withHeadline: NSLocalizedString("EMAIL_STRING", comment: ""),
            withContent: user.email
        )
        setupSegmentView(
            withHeadline: NSLocalizedString("PHONE_STRING", comment: ""),
            withContent: user.phone
        )
        setupSegmentView(
            withHeadline: NSLocalizedString("WEBSITE_STRING", comment: ""),
            withContent: user.website
        )
    }
    
    private func setupNavigationTitle() {
        title = user?.name
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        condPrint(self.user!)
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
        setupStackView()
        placeSegmentViews()
        

        
    }
}
