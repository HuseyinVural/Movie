//
//  MovieDetailCoordinator.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import ToolKit
import UIKit
import MVVMKit

public protocol MovieDetailCoordinatable: AnyObject, Coordinator {}

public protocol MovieDetailCoordinatorDelegate: AnyObject {}

public final class MovieDetailCoordinator: MovieDetailCoordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public weak var parent: Coordinator?
    public weak var delegate: MovieDetailCoordinatorDelegate?
    public var navigationController: UINavigationController?

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = MovieDetailViewModel(coordinator: self)
        let controller = MovieDetailViewController(viewModel: viewModel, bundle: .module)
        navigationController?.pushViewController(controller, animated: true)
    }
}

