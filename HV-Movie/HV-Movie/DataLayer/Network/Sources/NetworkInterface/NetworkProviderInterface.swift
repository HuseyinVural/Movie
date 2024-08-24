//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

public protocol NetworkProviderInterface {
    func request<T: HTTPTask>(_ task: T) async throws -> T.Response
}
