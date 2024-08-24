//
//  MockNetworkProvider.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
@testable import Data
@testable import NetworkInterface

final class MockNetworkProvider: NetworkProviderInterface {
    var result: Result<Any, Error>?
    
    func request<T: HTTPTask>(_ task: T) async throws -> T.Response {
        if let result = result {
            switch result {
            case .success(let response):
                return response as! T.Response
            case .failure(let error):
                throw error
            }
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
