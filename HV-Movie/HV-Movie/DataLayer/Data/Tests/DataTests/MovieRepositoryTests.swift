//
//  DataTests.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import XCTest
@testable import Data

final class MovieRepositoryTests: XCTestCase {
    private var repository: MovieRepository!
    private var sut: MockNetworkProvider!
    private var mockStorage: MockKeyValueStorage!
    
    override func setUp() {
        super.setUp()
        sut = MockNetworkProvider()
        mockStorage = MockKeyValueStorage()
        repository = MovieRepository(sut, storage: mockStorage)
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        mockStorage = nil
        super.tearDown()
    }
    
    func testGetPopularMovies_WhenCalledWithPageParameter_UsesNetworkProviderAndReturnsResponse() async throws {
        // Arrange
        let expectedResponse = PopularMoviesResponseItem(page: 1)
        sut.result = .success(expectedResponse)
        
        // Act
        let response = try await repository.getPopularMovies(1)
        
        // Assert
        XCTAssertEqual(response.page, expectedResponse.page)
    }
    
    func testGetPopularMovies_WhenNetworkRequestFails_ThrowsCorrectError() async throws {
        // Arrange
        let expectedError = URLError(.badServerResponse)
        sut.result = .failure(expectedError)
        
        // Act & Assert
        do {
            _ = try await repository.getPopularMovies(1)
            XCTFail("Expected error, but no error was thrown.")
        } catch {
            XCTAssertEqual(error as? URLError, expectedError)
        }
    }
    
    func testGetMovieDetail_WhenCalledWithIDParameter_UsesNetworkProviderAndReturnsResponse() async throws {
        // Arrange
        let expectedResponse = MovieDetailResponseItem(posterPath: "some_path")
        sut.result = .success(expectedResponse)
        
        // Act
        let response = try await repository.getMovieDetail(asset: 123)
        
        // Assert
        XCTAssertEqual(response.posterPath, expectedResponse.posterPath)
    }
    
    func testSetFavoriteMovie_WhenCalled_AddsMovieToInMemoryCache() throws {
        // Arrange
        let movieId = 123
        
        // Act
        try repository.setFavorite(movie: movieId)
        
        // Assert
        XCTAssertTrue(repository.isFavoriteMovie(movie: movieId))
    }
    
    func testRemoveFavoriteMovie_WhenCalled_RemovesMovieFromInMemoryCache() throws {
        // Arrange
        let movieId = 123
        try repository.setFavorite(movie: movieId)
        
        // Act
        try repository.removeFavorite(movie: movieId)
        
        // Assert
        XCTAssertFalse(repository.isFavoriteMovie(movie: movieId))
    }
    
    func testFetchFavoritesFromStorage_WhenCalled_LoadsFavoritesIntoInMemoryCache() {
        // Arrange
        let expectedFavorites: [Int: Bool] = [123: true, 456: true]
        mockStorage.save(expectedFavorites, forKey: StoreKeys.favorites.rawValue)
        
        // Act
        repository.fetchAllFavoriteFromStorage()
        
        // Assert
        XCTAssertTrue(repository.isFavoriteMovie(movie: 123))
        XCTAssertTrue(repository.isFavoriteMovie(movie: 456))
    }
    
    func testSaveAllFavoriteToStorage_WhenCalled_SavesInMemoryCacheToPersistentStorage() {
        // Arrange
        try? repository.setFavorite(movie: 123)
        try? repository.setFavorite(movie: 456)
        
        // Act
        repository.saveAllFavoriteToStorage()
        
        // Assert
        let storedFavorites = mockStorage.load(forKey: StoreKeys.favorites.rawValue) as [Int: Bool]?
        XCTAssertEqual(storedFavorites?[123], true)
        XCTAssertEqual(storedFavorites?[456], true)
    }
}
