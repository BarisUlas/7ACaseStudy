//
//  CustomSegmentView.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import UIKit

class CustomSegmentView: UIView {
    
    private var headlineString: String!
    private var contentString: String!
    
    private func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
    }
    
    private func setupLabels() {
        
        let headlineLabel = UILabel()
        headlineLabel.text = headlineString
        headlineLabel.font = .preferredFont(forTextStyle: .headline)
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headlineLabel)
        
        let contentLabel = UILabel()
        contentLabel.text = contentString
        contentLabel.font = .preferredFont(forTextStyle: .body)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            contentLabel.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor)
        ])
    }
    
    init(withHeadlineString headlineString: String, withContentString contentString: String) {
        super.init(frame: CGRect.zero)
        
        self.headlineString = headlineString
        self.contentString = contentString
        
        setupView()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
