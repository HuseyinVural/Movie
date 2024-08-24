//
//  MovieRepository.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import NetworkInterface
import StorageInterface

public protocol MovieRepositoryable: FavoriteManageable {
    func getPopularMovies(_ page: Int) async throws -> PopularMoviesResponseItem
    func getMovieDetail(asset id: Int) async throws -> MovieDetailResponseItem
}

public protocol FavoriteManageable {
    func setFavorite(movie id: Int) throws
    func removeFavorite(movie id: Int) throws
    func isFavoriteMovie(movie id: Int) -> Bool
    func fetchAllFavoriteFromStorage()
    func saveAllFavoriteToStorage()
}

public class MovieRepository: MovieRepositoryable {
    private let networkProvider: NetworkProviderInterface
    private let storage: KeyValueStorable
    private var inMemoryCacheOfFavs: [Int: Bool] = [:]

    public init(_ networkProvider: NetworkProviderInterface, storage: KeyValueStorable) {
        self.networkProvider = networkProvider
        self.storage = storage
    }
    
    // MARK: Movie Network Op
    public func getPopularMovies(_ page: Int) async throws -> PopularMoviesResponseItem {
        return try await networkProvider.request(PopularMoviesRequestItem(page: page))
    }
    
    public func getMovieDetail(asset id: Int) async throws -> MovieDetailResponseItem {
        return try await networkProvider.request(MovieDetailRequestItem(id: id))
    }
    
    // MARK: Movie Fav Op - FavoriteManageable
    public func setFavorite(movie id: Int) throws {
        inMemoryCacheOfFavs[id] = true
    }
    
    public func removeFavorite(movie id: Int) throws {
        inMemoryCacheOfFavs.removeValue(forKey: id)
    }
    
    public func isFavoriteMovie(movie id: Int) -> Bool {
        return inMemoryCacheOfFavs[id] != nil
    }
    
    public func fetchAllFavoriteFromStorage() {
        inMemoryCacheOfFavs = storage.load(forKey: StoreKeys.favorites.rawValue) ?? [:]
    }
    
    public func saveAllFavoriteToStorage() {
        storage.save(inMemoryCacheOfFavs, forKey: StoreKeys.favorites.rawValue)
    }
}

enum StoreKeys: String {
    case favorites
}
