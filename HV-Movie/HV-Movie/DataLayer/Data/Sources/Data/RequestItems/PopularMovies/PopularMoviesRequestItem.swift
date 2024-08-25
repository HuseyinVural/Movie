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
    
    public init(page: Int, totalPages: Int, results: [MovieResponseItem]) {
        self.page = page
        self.totalPages = totalPages
        self.results = results
    }
}

public struct MovieResponseItem: Decodable {
    public let id: Int
    public let posterPath: String
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let voteAverage: Double
    
    public init(id: Int, posterPath: String, title: String, overview: String, releaseDate: String, voteAverage: Double) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}
