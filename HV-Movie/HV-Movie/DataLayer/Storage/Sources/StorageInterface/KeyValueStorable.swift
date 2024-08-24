//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

public protocol KeyValueStorable {
    func save<T: Codable>(_ value: T, forKey key: String)
    func load<T: Codable>(forKey key: String) -> T?
}
