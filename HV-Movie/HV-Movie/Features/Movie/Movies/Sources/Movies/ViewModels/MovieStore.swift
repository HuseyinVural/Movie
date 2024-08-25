//
//  MovieStore.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import ToolKit
import Foundation

final class MovieStore {
    private var movies: [MovieCellDisplayItem] = []
    private let queue = DispatchQueue(label: "list.movies.store", attributes: .concurrent)
    
    func updateMovies(_ newMovies: [MovieCellDisplayItem]) {
        queue.async(flags: .barrier) {
            self.movies = newMovies
        }
    }
    
    func movieCount() -> Int {
        return queue.sync {
            return movies.count
        }
    }
    
    func movie(at index: Int) -> MovieCellDisplayItem? {
        return queue.sync {
            return movies[safe: index]
        }
    }
}
