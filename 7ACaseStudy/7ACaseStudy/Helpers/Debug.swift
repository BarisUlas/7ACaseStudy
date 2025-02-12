//
//  Debug.swift
//  7ACaseStudy
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import Foundation

func condPrint(_ items: Any...) {
#if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
#endif
}
