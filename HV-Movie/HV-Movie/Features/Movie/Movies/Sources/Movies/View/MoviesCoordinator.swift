//
//  MoviesCoordinator.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import ToolKit
import UIKit

public protocol MoviesCoordinatable: AnyObject, Coordinator {
    func showMovieDetail(asset id: Int)
}

public protocol MoviesCoordinatorDelegate: MoviesCoordinatable {}

public final class MoviesCoordinator: MoviesCoordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public weak var delegate: MoviesCoordinatorDelegate?
    public weak var parent: Coordinator?
    public var navigationController: UINavigationController?

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = MoviesViewModel(coordinator: delegate)
        let moviesViewController = MoviesViewController(viewModel: viewModel, bundle: .module)
        navigationController?.pushViewController(moviesViewController, animated: true)
    }
    
    public func showMovieDetail(asset id: Int) {
        delegate?.showMovieDetail(asset: id)
    }
}
