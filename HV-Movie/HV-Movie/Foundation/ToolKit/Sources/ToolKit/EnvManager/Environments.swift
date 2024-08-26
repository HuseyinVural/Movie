//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

/// An enum representing different environments (development and production) for API calls.
/// The `prod` case is intentionally left unimplemented for future expansion.
/// This enum is designed to be extended for selecting platforms and base API endpoints within the application.
public enum Environments {
    case dev
    case prod
    
    public func apiURL(_ version: ApiVersion = .v3) -> URL {
        return switch self {
        case .dev:
            URL(string: "https://api.themoviedb.org/" + version.rawValue)!
        case .prod:
            fatalError("Not implemented")
        }
    }
    
    public func cdnURLPrefix() -> String {
        return "https://image.tmdb.org/t/p/"
    }
    
    public enum ApiVersion: String {
        case v3 = "3"
    }
}
