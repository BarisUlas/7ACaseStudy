//
//  User.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// This is our User Model. Since this case study only requires
// the specific parts of the response, redundant fields have
// been removed.

import Foundation

struct User: Codable {
    let name: String
    let email: String
    let phone: String
    let website: String
}
