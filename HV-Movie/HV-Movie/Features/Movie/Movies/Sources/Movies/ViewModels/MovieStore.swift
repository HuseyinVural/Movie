//
//  MovieStore.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import ToolKit
import Foundation

protocol MovieStoreable {
    func updateMovies(_ newMovies: [MovieCellDisplayItem])
    func getMovies() -> [MovieCellDisplayItem]
    func movie(at index: Int) -> MovieCellDisplayItem?
}

final class MovieStore: MovieStoreable {
    private var movies: [MovieCellDisplayItem] = []
    private let queue = DispatchQueue(label: "list.movies.store", attributes: .concurrent)
    
    func updateMovies(_ newMovies: [MovieCellDisplayItem]) {
        queue.async(flags: .barrier) {
            self.movies.append(contentsOf: newMovies)
        }
    }
    
    func getMovies() -> [MovieCellDisplayItem] {
        return queue.sync {
            return movies
        }
    }
    
    func movie(at index: Int) -> MovieCellDisplayItem? {
        return queue.sync {
            return movies[safe: index]
        }
    }
}
