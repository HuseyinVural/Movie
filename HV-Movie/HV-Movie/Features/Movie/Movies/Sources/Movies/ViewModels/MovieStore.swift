//
//  MovieStore.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import ToolKit
import Foundation
import MVVMKit

protocol MovieStoreable: AnyObject {
    var isFilterEnable: Bool { get set }
    func updateMovies(_ newMovies: [MovieCellDisplayItem])
    func getMovies(forceFilter: Bool) -> [MovieCellDisplayItem]
    func movie(at index: Int) -> MovieCellDisplayItem?
    func filter(by searchText: String)
}

extension MovieStoreable {
    func getMovies() -> [MovieCellDisplayItem] {
        return getMovies(forceFilter: false)
    }
}

final class MovieStore: MovieStoreable {
    private var movies: [MovieCellDisplayItem] = []
    private var filteredMovies: [MovieCellDisplayItem] = []
    private let queue = DispatchQueue(label: "list.movies.store", attributes: .concurrent)
    var isFilterEnable: Bool = false
    
    func updateMovies(_ newMovies: [MovieCellDisplayItem]) {
        queue.async(flags: .barrier) {
            self.movies.append(contentsOf: newMovies)
        }
    }
    
    func getMovies(forceFilter: Bool) -> [MovieCellDisplayItem] {
        return queue.sync {
            return isFilterEnable && !forceFilter ? filteredMovies : movies
        }
    }
    
    func movie(at index: Int) -> MovieCellDisplayItem? {
        return getMovies()[safe: index]
    }
    
     func filter(by searchText: String) {
         isFilterEnable = !searchText.isEmpty
         
         let filteredMovies = getMovies(forceFilter: true).filter { movie in
             return movie.title.lowercased().contains(searchText.lowercased())
         }
         
         queue.async(flags: .barrier) {
             self.filteredMovies = filteredMovies
         }
    }
}
