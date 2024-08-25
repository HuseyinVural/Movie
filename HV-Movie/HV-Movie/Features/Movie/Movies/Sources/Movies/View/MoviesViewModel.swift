//
//  MoviesViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit

public enum MoviesPageActions {
    case refreshMoviesData
}

public protocol MoviesViewModelable: BaseViewModelable, ActionSendable where ActionType == MoviesPageActions {}

class MoviesViewModel: BaseViewModel, MoviesViewModelable {
    typealias ActionType = MoviesPageActions
    var observer: ((MoviesPageActions) -> Void)?
    weak var coordinator : MoviesCoordinatable?
    
    init(coordinator: MoviesCoordinatable?) {
        self.coordinator = coordinator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.loading)
        sendAction(.refreshMoviesData)
    }
}
