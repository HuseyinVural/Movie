//
//  MoviesCoordinator.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import Foundation
import ToolKit
import Data
import MVVMKit

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
        let handler = MovieListHandler()
        let viewModel = MoviesViewModel(
            coordinator: self,
            repository: DependencyContainer.shared.resolve(RepositoryContainer.self).movieRepository,
            listHandler: handler, 
            envManager: DependencyContainer.shared.resolve(EnvManageable.self)
        )
        handler.viewModel = viewModel
        let moviesViewController = MoviesViewController(viewModel: viewModel, bundle: .module)
        navigationController?.pushViewController(moviesViewController, animated: true)
    }
    
    public func showMovieDetail(asset id: Int) {
        delegate?.showMovieDetail(asset: id)
    }
}
