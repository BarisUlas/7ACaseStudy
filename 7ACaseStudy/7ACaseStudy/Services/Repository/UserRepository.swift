//
//  UserRepository.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    
    func fetchUsers(completion: @escaping (Result<[User], any Error>) -> Void) {
        guard let url = URL(string: Endpoint.URL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(
                    NSError(domain: "", code: 1))
                )
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
