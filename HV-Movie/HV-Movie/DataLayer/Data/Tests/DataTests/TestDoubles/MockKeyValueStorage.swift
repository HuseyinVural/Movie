//
//  MockKeyValueStorage.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
@testable import Data
@testable import StorageInterface

final class MockKeyValueStorage: KeyValueStorable {
    private var storage: [String: Any] = [:]
    
    func save<T: Codable>(_ value: T, forKey key: String) {
        storage[key] = value
    }
    
    func load<T: Codable>(forKey key: String) -> T? {
        return storage[key] as? T
    }
}
