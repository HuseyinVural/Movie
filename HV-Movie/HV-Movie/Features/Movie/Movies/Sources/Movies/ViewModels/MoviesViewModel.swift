//
//  MoviesViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit
import Data
import LocalizationKit
import MVVMKit

enum MoviesPageActions {
    case bindList(MovieListHandleable)
    case reload
}

protocol MoviesViewModelable: BaseViewModelable, ActionSendable where ActionType == MoviesPageActions {
    func didChangeSearchText(_ key: String)
    func didSearchClear()
    func didTapSearchDone()
}

final class MoviesViewModel: BaseViewModel, MoviesViewModelable {
    typealias ActionType = MoviesPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : MoviesCoordinatable?
    
    private let repository: MovieRepositoryable
    private let listHandler: MovieListHandleable
    private var page = Page(current: 1, total: 1)
    private var isLoading = false
    private var envManager: EnvManageable
    
    init(
        coordinator: MoviesCoordinatable?,
        repository: MovieRepositoryable,
        listHandler: MovieListHandleable,
        envManager: EnvManageable
    ) {
        self.coordinator = coordinator
        self.repository = repository
        self.listHandler = listHandler
        self.envManager = envManager
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.bindList(listHandler))
        sendAction(.reload)
        sendAction(.loading(isHidden: false))
        fetchData()
    }
    
    func didChangeSearchText(_ key: String) {
        listHandler.store.filter(by: key)
        listHandler.store.isFilterEnable = !key.isEmpty
        sendAction(.reload)
    }
    
    func didSearchClear() {
        disableSearchFilter()
    }
    
    func didTapSearchDone() {
        sendAction(.closeKeyboard)
    }
    
    private func fetchData(page: Int = 1) {
        Task {
            sendAction(.loading(isHidden: true))
            defer {
                isLoading = false
            }
            
            guard let result = try? await execute(await self.repository.getPopularMovies(page)) else {
                return
            }
            parse(result)
            
            sendAction(.reload)
            sendAction(.loading(isHidden: true))
        }
    }
    
    private func parse(_ response : PopularMoviesResponseItem) {
        page.update(current: response.page, total: response.totalPages)

        listHandler.store.updateMovies(response.results.map({ item in
            return .init(
                id: item.id,
                title: item.title,
                rank: String(format: "%.2f", item.voteAverage),
                releaseDate: item.releaseDate.toReadableDate() ?? "-/-",
                overview: item.overview,
                imageURL: URL(string: envManager.current.cdnURLPrefix() + "w185/" + item.posterPath),
                moreTile: "\(Texts.General.more.localized) ➜"
            )
        }))
    }
    
    private func shouldLoadNextPage(at indexPath: IndexPath) -> Bool {
        let itemCount = listHandler.store.getMovies().count
        return indexPath.row == itemCount - 5 && page.hasMorePages && !isLoading && !listHandler.store.isFilterEnable
    }
    
    private func disableSearchFilter() {
        listHandler.store.isFilterEnable = false
        sendAction(.reload)
    }
}

extension MoviesViewModel: MovieListManageable {
    func didDisplayCell(at indexPath: IndexPath) {
        guard shouldLoadNextPage(at: indexPath) else {
            return
        }
        
        fetchData(page: page.current + 1)
    }
    
    func didSelectMovie(_ movie: MovieCellDisplayItem?) {
        guard let movie else {
            sendAction(.error(Texts.General.error.localized))
            return
        }
        
        coordinator?.showMovieDetail(asset: movie.id)
    }
}
