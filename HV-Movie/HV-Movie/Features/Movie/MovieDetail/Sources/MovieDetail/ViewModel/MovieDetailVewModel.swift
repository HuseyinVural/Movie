//
//  MovieDetailViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit
import MVVMKit
import Data
import LocalizationKit

enum MovieDetailPageActions {
    case bindButtons
    case setDetail(MovieDetailDisplayItem)
    case setFavoriteStatus(isFavorite: Bool)
    case setPageTitle(String)
}

protocol MovieDetailViewModelable: BaseViewModelable, ActionSendable where ActionType == MovieDetailPageActions {
    func didTapFavoriteButton()
    func didTapPopButton()
}

final class MovieDetailViewModel: BaseViewModel, MovieDetailViewModelable {
    typealias ActionType = MovieDetailPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : MovieDetailCoordinatable?
    
    private let repository: MovieRepositoryable
    private var envManager: EnvManageable
    private var id: Int
    private var isFavorite: Bool
    
    init(
        id: Int,
        coordinator: MovieDetailCoordinatable?,
        repository: MovieRepositoryable,
        envManager: EnvManageable
    ) {
        self.id = id
        self.coordinator = coordinator
        self.repository = repository
        self.envManager = envManager
        isFavorite = repository.isFavoriteMovie(movie: id)
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.bindButtons)
        sendAction(.setPageTitle(Texts.General.detail.localized))
        fetchData()
        sendAction(.setFavoriteStatus(isFavorite: isFavorite))
    }
    
    func didTapFavoriteButton() {
        isFavorite.toggle()
        sendAction(.setFavoriteStatus(isFavorite: isFavorite))
        
        /// Do Optimistic Handle
        do {
            if isFavorite {
                try repository.setFavorite(movie: id)
            } else {
                try repository.removeFavorite(movie: id)
            }
    
            repository.saveAllFavoriteToStorage()
        } catch {
            logger?.log(error, with: [:])
        }
    }
    
    func didTapPopButton() {
        coordinator?.popViewController()
        coordinator?.didFinish()
    }
    
    private func fetchData() {
        Task {
            sendAction(.loading(isHidden: false))
            
            guard let result = try? await execute(await self.repository.getMovieDetail(asset: self.id)) else {
                return
            }
            parse(result)
            
            sendAction(.loading(isHidden: true))
        }
    }
    
    private func parse(_ item : MovieDetailResponseItem) {
        sendAction(.setDetail(.init(
            id: item.id,
            title: item.title,
            subtitle: item.genres.map({ $0.name }).joined(separator: ", "),
            rank: String(format: "%.2f", item.voteAverage),
            releaseDate: item.releaseDate.toReadableDate() ?? "-/-",
            country: item.originCountry.first ?? "",
            overview: item.overview,
            tagline: item.tagline,
            imageURL: URL(string: envManager.current.cdnURLPrefix() + "w780/" + item.backdropPath)
        )))
    }
    
    deinit {
        coordinator?.didFinish()
    }
}

