//
//  NetworkManager.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

// NetworkManager is a general (or base) class for
// making network calls. It just makes the request
// for the given URL, and returns the result

// We will use this class to create UserRepository class
// for decoding the results of the request. Enjoy the ride

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            completion(.success(data))
        }.resume()
    }
}
