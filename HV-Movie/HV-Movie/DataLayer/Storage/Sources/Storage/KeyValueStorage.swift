//
//  KeyValueStorage.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import StorageInterface

/// `KeyValueStorage` is a wrapper class for `UserDefaults` that provides
/// an interface for saving and loading `Codable` types.
///
/// This implementation currently supports `String` and `Data` types directly,
/// and other `Codable` types via JSON encoding and decoding.
///
/// Additional primitive types like `Int`, `Bool`, and `Double` can be added similarly
/// by extending the `save` and `load` methods.
final public class KeyValueStorage: KeyValueStorable {
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func save<T>(_ value: T, forKey key: String) where T: Codable {
        if let value = value as? String {
            defaults.set(value, forKey: key)
        } else if let value = value as? Data {
            defaults.set(value, forKey: key)
        } else {
            let data = try? JSONEncoder().encode(value)
            defaults.set(data, forKey: key)
        }
    }
    
    public func load<T>(forKey key: String) -> T? where T: Codable {
        if T.self == String.self {
            return defaults.string(forKey: key) as? T
        } else if T.self == Data.self {
            return defaults.data(forKey: key) as? T
        } else {
            guard let data = defaults.data(forKey: key), let value = try? JSONDecoder().decode(T.self, from: data) else {
                return nil
            }
            return value
        }
    }
}
