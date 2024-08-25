//
//  MovieDetailViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit

enum MovieDetailPageActions {
    case setData
}

protocol MovieDetailViewModelable: BaseViewModelable, ActionSendable where ActionType == MovieDetailPageActions {}

final class MovieDetailViewModel: BaseViewModel, MovieDetailViewModelable {
    typealias ActionType = MovieDetailPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : MovieDetailCoordinatable?
    
    init(coordinator: MovieDetailCoordinatable?) {
        self.coordinator = coordinator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.loading(isHidden: false))
        sendAction(.setData)
    }
    
    deinit {
        coordinator?.didFinish()
    }
}
