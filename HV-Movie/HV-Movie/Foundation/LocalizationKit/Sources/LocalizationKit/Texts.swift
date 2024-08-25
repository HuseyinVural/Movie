//
//  MovieDetailCoordinator.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//


import Foundation

/// `Texts.General` enum provides localized keys for general application messages.
public enum Texts {
    public enum General: String, KeyLocalizable {
        public var lookPath: Bundle {
            return .module
        }
        
        case error = "error.message"
        case loading = "loading.message"
    }
}

/// It conforms to `KeyLocalizable` to easily retrieve localized strings.
/// Each case corresponds to a specific localization key for common use cases like errors and loading states.
/// By lookPath you can override bundle
public protocol KeyLocalizable {
    var rawValue: String { get }
    var localized: String { get }
    var lookPath: Bundle { get }
}

public extension KeyLocalizable {
    var localized: String {
        return lookPath.localizedString(forKey: self.rawValue, value: nil, table: nil)
    }
}
