//
//  MovieStoreTests.swift
//
//
//  Created by Huseyin Vural on 26.08.2024.
//

import XCTest
@testable import Movies

final class MovieStoreTests: XCTestCase {

    var store: MovieStore!

    override func setUp() {
        super.setUp()
        store = MovieStore()
    }

    override func tearDown() {
        store = nil
        super.tearDown()
    }

    func testUpdateMovies_StoreMoviesSuccessfully_StoresCorrectly() {
        let movie1 = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")
        let movie2 = MovieCellDisplayItem(id: 2, title: "Movie 2", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")

        store.updateMovies([movie1, movie2])

        let movies = store.getMovies()
        XCTAssertEqual(movies.count, 2)
        XCTAssertEqual(movies[0].title, "Movie 1")
        XCTAssertEqual(movies[1].title, "Movie 2")
    }

    func testGetMovies_NoFilterApplied_ReturnsAllMovies() {
        let movie = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")

        store.updateMovies([movie])

        let movies = store.getMovies()
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies[0].title, "Movie 1")
    }

    func testGetMovies_FilterApplied_ReturnsFilteredMovies() {
        let movie1 = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")
        let movie2 = MovieCellDisplayItem(id: 2, title: "Another Mo", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")

        store.updateMovies([movie1, movie2])
        store.filter(by: "Movie")

        let movies = store.getMovies()
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies[0].title, "Movie 1")
    }

    func testMovieAtIndex_ValidIndex_ReturnsCorrectMovie() {
        let movie = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")

        store.updateMovies([movie])

        let retrievedMovie = store.movie(at: 0)
        XCTAssertNotNil(retrievedMovie)
        XCTAssertEqual(retrievedMovie?.title, "Movie 1")
    }

    func testFilter_ClearedWhenSearchTextIsEmpty_ReturnsAllMovies() {
        let movie1 = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")
        let movie2 = MovieCellDisplayItem(id: 2, title: "Another Movie", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")

        store.updateMovies([movie1, movie2])
        store.filter(by: "Movie")
        
        store.filter(by: "")
        
        let movies = store.getMovies()
        XCTAssertEqual(movies.count, 2)
    }
    
    func testConcurrent_UpdateAndRead_NoRaceCondition() {
        let movie1 = MovieCellDisplayItem(id: 1, title: "Movie 1", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")
        let movie2 = MovieCellDisplayItem(id: 2, title: "Movie 2", rank: "", releaseDate: "", overview: "", imageURL: nil, moreTile: "")
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        let iterations = 10
        
        for _ in 0..<iterations {
            dispatchGroup.enter()
            queue.async {
                self.store.updateMovies([movie1, movie2])
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            queue.async {
                _ = self.store.getMovies()
                dispatchGroup.leave()
            }
        }
        
        let result = dispatchGroup.wait(timeout: .now() + 10)
        XCTAssertEqual(result, .success, "The test timed out, indicating a potential race condition or deadlock.")
        
        // Son olarak veri tutarlılığını kontrol edin
        let movies = store.getMovies()
        XCTAssertFalse(movies.isEmpty, "The store should not be empty after concurrent updates.")
        XCTAssertTrue(movies.contains(where: { $0.title == "Movie 1" }), "The store should contain 'Movie 1'.")
        XCTAssertTrue(movies.contains(where: { $0.title == "Movie 2" }), "The store should contain 'Movie 2'.")
    }

}
