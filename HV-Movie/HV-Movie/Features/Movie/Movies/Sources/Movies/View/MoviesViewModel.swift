//
//  MoviesViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit

enum MoviesPageActions {
    case refreshMoviesData
}

protocol MoviesViewModelable: BaseViewModelable, ActionSendable where ActionType == MoviesPageActions {}

final class MoviesViewModel: BaseViewModel, MoviesViewModelable {
    typealias ActionType = MoviesPageActions
    var observer: ((MoviesPageActions) -> Void)?
    weak var coordinator : MoviesCoordinatable?
    
    init(coordinator: MoviesCoordinatable?) {
        self.coordinator = coordinator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.loading(isHidden: false))
        sendAction(.refreshMoviesData)
    }
}
