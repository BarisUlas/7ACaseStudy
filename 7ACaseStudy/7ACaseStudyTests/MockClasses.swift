//
//  MockClasses.swift
//  7ACaseStudyTests
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// Simple mock class of the UserRepositoryProtocol
// to make it take dummy users from the caller
// instead of actually grabbing them from a network call

import Foundation
@testable import CaseStudy7A

class MockUserRepository: UserRepositoryProtocol {
    
    var shouldSimulateFailure: Bool = false
    var hardcodedUsers: [User] = []
    
    func fetchUsers(completion: @escaping (Result<[User], any Error>) -> Void) {
        if shouldSimulateFailure {
            completion(.failure(NSError(domain: "test", code: -1)))
        }
        else {
            // make sure to call completion with
            // the given hardcoded (dummy) users
            completion(.success(hardcodedUsers))
        }
    }
}
