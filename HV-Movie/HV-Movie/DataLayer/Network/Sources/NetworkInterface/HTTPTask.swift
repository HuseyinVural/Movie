// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// `HTTPTask` protocol defines a blueprint for HTTP requests with default configurations via an extension.
/// That config can be override from other modules
public protocol HTTPTask {
    var authorization: AuthorizationType { get }
    var route: Route { get }
    var parameters: [String: Any]? { get }
    var defaultParameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var defaultHeaders: [String: String] { get }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
    var baseURL: URL { get }

    associatedtype Response: Decodable
}

public extension HTTPTask {
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return .url
    }
    
    var defaultParameters: [String: Any]? {
        return [:]
    }

    var defaultHeaders: [String: String] {
        return [:]
    }

    var isLoggingEnabled: Bool {
        return false
    }

    var authorization: AuthorizationType {
        return .bearer
    }
    
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        .convertFromSnakeCase
    }
}
