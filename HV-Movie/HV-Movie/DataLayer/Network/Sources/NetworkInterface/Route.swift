//
//  Route.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

/// It can be expanded with the help of new method types and enums.
/// Stores path information in method
public enum Route {
    case get(String)
    
    public var path: String {
        switch self {
        case .get(let path): return path
        }
    }
    
    public var method: String {
        switch self {
        case .get: return "GET"
        }
    }
}
