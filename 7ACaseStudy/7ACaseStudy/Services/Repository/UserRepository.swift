//
//  UserRepository.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// UserRepository uses NetworkManager to fetch users.
// It uses the response returned from NetworkManager
// to decode the results into User struct.

import Foundation

// Delegate protocol for conformers
protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    
    func fetchUsers(completion: @escaping (Result<[User], any Error>) -> Void) {
        guard let url = URL(string: Endpoint.URL) else { return }
        
        // here we don't have to deal with general networking cases
        // since networkmanager will do that for us. We just need to
        // worry about the result type and decoding the data
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
