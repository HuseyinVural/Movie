//
//  PopularMoviesRequestItem.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import NetworkInterface

struct PopularMoviesRequestItem: HTTPTask {
    typealias Response = PopularMoviesResponseItem

    let route: Route
    let parameters: [String : Any]?
    
    init(page: Int) {
        route = .get("/movie/popular")
        parameters = ["page": page]
    }
}

public struct PopularMoviesResponseItem: Decodable {
    public let page: Int
    public let totalPages: Int
    public let results: [MovieResponseItem]
}

public struct MovieResponseItem: Decodable {
    public let id: Int
    public let posterPath: String
    public let title: String
    public let overview: String
    public let voteCount: Int
    public let voteAverage: Double
}
