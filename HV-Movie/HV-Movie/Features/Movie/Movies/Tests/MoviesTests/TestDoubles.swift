//
//  Mocks.swift
//  
//
//  Created by Huseyin Vural on 26.08.2024.
//

import Foundation
import XCTest
@testable import Movies
import Data
import ToolKit


class MockMovieRepository: MovieRepositoryable {
    func setFavorite(movie id: Int) throws {}
    func removeFavorite(movie id: Int) throws {}
    func isFavoriteMovie(movie id: Int) -> Bool {
        return false
    }
    func fetchAllFavoriteFromStorage() {}
    func saveAllFavoriteToStorage() {}
    
    var mockResult: Result<PopularMoviesResponseItem, Error>?
    var fetchPage: Int?
    
    func getPopularMovies(_ page: Int) async throws -> PopularMoviesResponseItem {
        fetchPage = page
        if let result = mockResult {
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        }
        return PopularMoviesResponseItem(page: page, totalPages: 1, results: [])
    }
    
    func getMovieDetail(asset id: Int) async throws -> MovieDetailResponseItem {
        fatalError()
    }
}

class MockMoviesCoordinator: MoviesCoordinatable {
    var childCoordinators: [Coordinator] = []
    var parent: Coordinator?
    var navigationController: UINavigationController?
    
    var selectedMovieId: Int?
    
    func start() {}
    
    func showMovieDetail(asset id: Int) {
        selectedMovieId = id
    }
    
    func didFinish() {}
}

class MockMovieListHandler: NSObject, MovieListHandleable {
    var store: MovieStoreable = MockMovieStore()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.getMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class MockEnvManager: EnvManageable {
    var current: Environments = .dev
    
    func setCurrentEnv(_ env: Environments) {
        current = env
    }
}

class MockMovieStore: MovieStoreable {
    var isFilterEnable: Bool = false
    private var movies: [MovieCellDisplayItem] = []
    
    func updateMovies(_ newMovies: [MovieCellDisplayItem]) {
        movies = newMovies
    }
    
    func getMovies(forceFilter: Bool = false) -> [MovieCellDisplayItem] {
        return movies
    }
    
    func movie(at index: Int) -> MovieCellDisplayItem? {
        return movies[index]
    }
    
    func filter(by searchText: String) {
        movies = movies.filter { $0.title.contains(searchText) }
    }
}
