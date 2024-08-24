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
    let page: Int
}
