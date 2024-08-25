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

enum MoviesPageActions {
    case bindList(MovieListHandleable)
    case reload
}

protocol MoviesViewModelable: BaseViewModelable, ActionSendable where ActionType == MoviesPageActions {}

final class MoviesViewModel: BaseViewModel, MoviesViewModelable {
    typealias ActionType = MoviesPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : MoviesCoordinatable?
    let repository: MovieRepositoryable
    let listHandler: MovieListHandleable
    
    init(
        coordinator: MoviesCoordinatable?,
        repository: MovieRepositoryable,
        listHandler: MovieListHandleable
    ) {
        self.coordinator = coordinator
        self.repository = repository
        self.listHandler = listHandler
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.bindList(listHandler))
        sendAction(.reload)
        sendAction(.loading(isHidden: false))
        fetchData()
    }
    
    func fetchData() {
        Task {
            guard let result = try? await execute(await self.repository.getPopularMovies(1)) else {
                return
            }
            
            listHandler.updateMovies(result.results.map({ item in
                let urlString = "https://image.tmdb.org/t/p/w200/" + item.posterPath
                let url = URL(string: urlString)
                let rank = "9.9"
                let date = "-/-"
                
                return .init(
                    id: item.id,
                    title: item.title,
                    rank: rank,
                    releaseDate: date,
                    overview: item.overview,
                    imageURL: url,
                    moreTile: "More ➜"
                )
            }))
            sendAction(.reload)
        }
    }
}

extension MoviesViewModel: MovieListManageable {
    func didDisplayCell(at indexPath: IndexPath) {
        #warning("Add pagination")
    }
    
    func didSelectMovie(_ movie: MovieCellDisplayItem?) {
        guard let movie else {
            sendAction(.error(Texts.General.error.localized))
            return
        }
        
        #warning("Add detail action")
    }
}
