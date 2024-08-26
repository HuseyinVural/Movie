//
//  MovieDetailCoordinator.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import ToolKit
import UIKit
import MVVMKit
import Data

public protocol MovieDetailCoordinatable: AnyObject, Coordinator {}

public protocol MovieDetailCoordinatorDelegate: AnyObject {}

public final class MovieDetailCoordinator: MovieDetailCoordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public weak var parent: Coordinator?
    public weak var delegate: MovieDetailCoordinatorDelegate?
    public var navigationController: UINavigationController?
    private let assetId: Int

    public init(navigationController: UINavigationController?, assetId: Int) {
        self.navigationController = navigationController
        self.assetId = assetId
    }

    public func start() {
        let viewModel = MovieDetailViewModel(
            id: assetId, 
            coordinator: self,
            repository: DependencyContainer.shared.resolve(RepositoryContainer.self).movieRepository,
            envManager: DependencyContainer.shared.resolve(EnvManageable.self)
        )
        let controller = MovieDetailViewController(viewModel: viewModel, bundle: .module)
        navigationController?.pushViewController(controller, animated: true)
    }
}

