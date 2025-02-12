//
//  NetworkManager.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation

class NetworkManager {
    
    // use singleton for consistency
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        guard let url = URL(string: Endpoint.URL) else {
            condPrint("unable to fetch items")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                condPrint(String(describing: error?.localizedDescription))
                completion(nil)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            }
            catch {
                print(String(describing: error.localizedDescription))
                completion(nil)
            }
        }.resume()
    }
}
