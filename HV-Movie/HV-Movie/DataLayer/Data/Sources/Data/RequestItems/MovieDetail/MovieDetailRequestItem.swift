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
    let posterPath: String
}
