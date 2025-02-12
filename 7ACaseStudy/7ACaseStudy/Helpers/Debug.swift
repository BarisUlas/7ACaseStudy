//
//  Debug.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation

// This is just a helper function that enables stdout across
// the entire project in Debug mode and disables it in Release builds
func condPrint(_ items: Any...) {
#if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
#endif
}
