//
//  MockClasses.swift
//  7ACaseStudyTests
//
//  Created by Baris U. Cukur on 12.02.2025.
//

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
            completion(.success(hardcodedUsers))
        }
    }
    
    
}
