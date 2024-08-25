//
//  File.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation

struct Page {
    var current: Int
    var total: Int
    
    var hasMorePages: Bool {
        return current < total
    }
    
    mutating func update(current: Int, total: Int) {
        self.current = current
        self.total = total
    }
}
