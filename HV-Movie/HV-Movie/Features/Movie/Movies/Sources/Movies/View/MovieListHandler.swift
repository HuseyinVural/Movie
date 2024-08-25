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
    var store: MovieStoreable { get }
}

final class MovieListHandler: NSObject, UITableViewDataSource, UITableViewDelegate, MovieListHandleable {
    let store: MovieStoreable
    public weak var viewModel: MovieListManageable?
    
    init(store: MovieStoreable = MovieStore()) {
        self.store = store
    }

    func updateMovies(_ movies: [MovieCellDisplayItem]) {
        store.updateMovies(movies)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.getMovies().count
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
