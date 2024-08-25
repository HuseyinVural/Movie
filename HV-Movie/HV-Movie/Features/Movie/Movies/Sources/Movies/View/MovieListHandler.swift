//
//  File.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit

protocol MovieListManageable: AnyObject {
    func didDisplayCell(at indexPath: IndexPath)
    func didSelectMovie(_ movie: MovieCellDisplayItem?)
}

protocol MovieListHandleable: UITableViewDelegate, UITableViewDataSource {
    func updateMovies(_ movies: [MovieCellDisplayItem])
}

final class MovieListHandler: NSObject, UITableViewDataSource, UITableViewDelegate, MovieListHandleable {
    private let store = MovieStore()
    public weak var viewModel: MovieListManageable?

    func updateMovies(_ movies: [MovieCellDisplayItem]) {
        store.updateMovies(movies)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.movieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        if let movie = store.movie(at: indexPath.row) {
            cell.configure(with: movie)
        }
        
        viewModel?.didDisplayCell(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectMovie(store.movie(at: indexPath.row))
    }
}
