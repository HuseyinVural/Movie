//
//  MovieDetailRequestItem.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import NetworkInterface

struct MovieDetailRequestItem: HTTPTask {
    typealias Response = MovieDetailResponseItem

    let route: Route
    
    init(id: Int) {
        route = .get("/movie/\(id)")
    }
}

public struct MovieDetailResponseItem: Decodable {
    public let id: Int
    public let title: String
    public let voteAverage: Double
    public let overview: String
    public let releaseDate: String
    public let genres: [Genre]
    public let backdropPath: String
    public let tagline: String
    public let voteCount: Int
}

public struct Genre: Decodable {
    public let id: Int
    public let name: String
}
