//
//  UserDetailVM.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is the viewmodel of the UserDetail VC.
// takes a User object to initalize from the Coordinator

import Foundation

class UserDetailVM {
    var user: User
    
    var name: String {
        user.name
    }

    // I have decided to add localization for some of the
    // strings used in the app. It only includes Turkish
    // and English for obvious reasons
    var emailHeadline: String {
        NSLocalizedString("EMAIL_STRING", comment: "")
    }

    var phoneHeadline: String {
        NSLocalizedString("PHONE_STRING", comment: "")
    }

    var websiteHeadline: String {
        NSLocalizedString("WEBSITE_STRING", comment: "")
    }

    var emailContent: String {
        user.email
    }

    var phoneContent: String {
        user.phone
    }

    var websiteContent: String {
        user.website
    }
    
    init(user: User) {
        self.user = user
    }
}
