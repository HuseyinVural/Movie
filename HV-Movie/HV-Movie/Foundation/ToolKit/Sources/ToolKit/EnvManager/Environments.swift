//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

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
    
    public enum ApiVersion: String {
        case v3 = "3"
    }
}
