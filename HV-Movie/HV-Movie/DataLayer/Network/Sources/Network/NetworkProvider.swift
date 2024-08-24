//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import NetworkInterface

public struct NetworkProvider: NetworkProviderInterface {
    private let session: URLSession
    private let tokenProvider: TokenProvider?
    
    // Init method to inject the URLSession and token reader dependency
    public init(session: URLSession = .shared, tokenProvider: TokenProvider? = nil) {
        self.session = session
        self.tokenProvider = tokenProvider
    }
    
    /// Sends an HTTP request and returns the decoded response.
    /// Adapts to iOS versions by using async/await with a fallback for pre-iOS 15.
    /// - Parameter task: The HTTP task containing request details.
    /// - Returns: The decoded response object conforming to the `Decodable` protocol.
    /// - Throws: An error if the request fails or if response validation/decoding fails.
    public func request<T: HTTPTask>(_ task: T) async throws -> T.Response {
        let urlRequest = try createURLRequest(for: task)
        
        let (data, response): (Data, URLResponse)
        if #available(iOS 15.0, *) {
            (data, response) = try await session.data(for: urlRequest)
        } else {
            (data, response) = try await session.asyncData(for: urlRequest)
        }
        
        try validateResponse(response)
        return try decodeResponse(data, with: task.keyDecodingStrategy)
    }
}

private extension NetworkProvider {
    
    /// Creates a URLRequest based on the provided task.
    /// - Parameter task: The HTTP task containing request details.
    /// - Returns: A configured URLRequest.
    func createURLRequest<T: HTTPTask>(for task: T) throws -> URLRequest {
        let url = try constructURL(for: task)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = task.route.method
        setHeaders(for: &urlRequest, task: task)
        
        return urlRequest
    }
    
    /// Constructs the final URL by appending path and query parameters.
    /// - Parameter task: The HTTP task containing request details.
    /// - Returns: The final URL with path and query parameters.
    func constructURL<T: HTTPTask>(for task: T) throws -> URL {
        var urlComponents = URLComponents(url: task.baseURL.appendingPathComponent(task.route.path), resolvingAgainstBaseURL: false)
        
        // Merge default parameters with provided parameters and set as query items
        setQueryParameters(for: &urlComponents, task: task)
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    /// Sets query parameters by merging default and provided parameters.
    /// - Parameter urlComponents: The URLComponents to which query parameters will be added.
    /// - Parameter task: The HTTP task containing request details.
    func setQueryParameters<T: HTTPTask>(for urlComponents: inout URLComponents?, task: T) {
        var mergedParameters = task.defaultParameters ?? [:]
        
        if let parameters = task.parameters {
            for (key, value) in parameters {
                mergedParameters[key] = value
            }
        }
        
        urlComponents?.queryItems = mergedParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    
    /// Sets the headers for the URLRequest.
    /// - Parameter urlRequest: The URLRequest to which headers will be added.
    /// - Parameter task: The HTTP task containing request details.
    func setHeaders<T: HTTPTask>(for urlRequest: inout URLRequest, task: T) {
        task.defaultHeaders.forEach { urlRequest.addValue($1, forHTTPHeaderField: $0) }
        
        if let token = tokenProvider?.accessToken(), let authorizationHeader = task.authorization.headerValue(token) {
            urlRequest.addValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }
    }
    
    /// Validates the response by checking the HTTP status code.
    /// - Parameter response: The URLResponse to be validated.
    /// - Throws: URLError if the response status code is not in the 200-299 range.
    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
    
    /// Decodes the data into the expected response type using the specified key decoding strategy.
    /// - Parameter data: The data to be decoded.
    /// - Parameter strategy: The key decoding strategy to be used.
    /// - Returns: The decoded response object.
    /// - Throws: An error if decoding fails.
    func decodeResponse<T: Decodable>(_ data: Data, with strategy: JSONDecoder.KeyDecodingStrategy) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = strategy
        return try decoder.decode(T.self, from: data)
    }
}


import Foundation

extension URLSession {
    /// Provides async/await support for URLSession.data(for:) method in iOS versions prior to iOS 15.
    /// - Parameters:
    ///   - request: The URLRequest to perform.
    /// - Returns: A tuple containing the Data and URLResponse.
    /// - Throws: An error if the request fails.
    func asyncData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
            task.resume()
        }
    }
}
