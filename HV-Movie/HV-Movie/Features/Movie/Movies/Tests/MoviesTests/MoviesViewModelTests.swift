//
//  MoviesViewModelTests.swift
//
//
//  Created by Huseyin Vural on 26.08.2024.
//

import XCTest
@testable import Movies
import Data
import ToolKit

final class MoviesViewModelTests: XCTestCase {
    private var viewModel: MoviesViewModel!
    private var mockRepository: MockMovieRepository!
    private var mockCoordinator: MockMoviesCoordinator!
    private var mockListHandler: MockMovieListHandler!
    private var mockEnvManager: MockEnvManager!
    private var mockMovieStore: MockMovieStore!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        mockCoordinator = MockMoviesCoordinator()
        mockListHandler = MockMovieListHandler()
        mockEnvManager = MockEnvManager()
        mockListHandler.store = MockMovieStore()
        
        viewModel = MoviesViewModel(
            coordinator: mockCoordinator,
            repository: mockRepository,
            listHandler: mockListHandler,
            envManager: mockEnvManager
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockCoordinator = nil
        mockListHandler = nil
        mockEnvManager = nil
        super.tearDown()
    }
    
    func testViewDidLoad_InitialLoad_BindListAndReloadSent() {
        // Arrange
        let expectation1 = XCTestExpectation(description: "BindList action sent")
        let expectation2 = XCTestExpectation(description: "Reload action sent")
        
        viewModel.observer = { action in
            switch action {
            case .bindList(let handler):
                XCTAssert(handler === self.mockListHandler)
                expectation1.fulfill()
            case .reload:
                expectation2.fulfill()
            }
        }
        
        // Act
        viewModel.viewDidLoad()
        
        // Assert
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    func testFetchData_SuccessfulResponse_UpdatesListAndSendsReload() async {
        // Arrange
        let mockResponse = PopularMoviesResponseItem(
            page: 1,
            totalPages: 1,
            results: [.init(id: 1, posterPath: "", title: "Test Title", overview: "Test Overview", releaseDate: "2024-07-24", voteAverage: 12)]
        )
        mockRepository.mockResult = .success(mockResponse)
        
        let expectation = XCTestExpectation(description: "Reload action sent")
        
        viewModel.observer = { action in
            if case .reload = action {
                expectation.fulfill()
            }
        }
        
        // Act
        viewModel.fetchData()
        
        // Assert
        await fulfillment(of: [expectation], timeout: 1.0)
        let expectedCount = await mockListHandler.store.getMovies().count
        XCTAssertEqual(expectedCount, 1, "There should be exactly 1 movie in the store after fetching data.")
    }

    
    func testFetchData_FailedResponse_NoActionSent() async {
        // Arrange
        mockRepository.mockResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        
        var actionSent = false
        
        viewModel.observer = { _ in
            actionSent = true
        }
        
        // Act
        viewModel.fetchData()
        
        // Assert
        XCTAssertFalse(actionSent)
    }
    
    func testDidChangeSearchText_UpdatesFilterAndReloads() {
        // Arrange
        let expectation = XCTestExpectation(description: "Reload action sent")
        
        viewModel.observer = { action in
            if case .reload = action {
                expectation.fulfill()
            }
        }
        
        // Act
        viewModel.didChangeSearchText("Test")
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockListHandler.store.isFilterEnable)
    }
    
    func testDidSelectMovie_CallsCoordinatorWithCorrectMovieId() {
        // Arrange
        let movie = MovieCellDisplayItem(
            id: 1,
            title: "Test Movie",
            rank: "7.5",
            releaseDate: "2024-07-24",
            overview: "Overview",
            imageURL: nil,
            moreTile: "More ➜"
        )
        mockListHandler.store.updateMovies([movie])
        
        // Act
        viewModel.didSelectMovie(movie)
        
        // Assert
        XCTAssertEqual(mockCoordinator.selectedMovieId, 1)
    }    
}
