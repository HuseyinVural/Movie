//
//  AppCoordinator.swift
//  HV-Movie
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import UIKit
import ToolKit
import Movies
import MovieDetail

class AppCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        let coordinator = MoviesCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: MoviesCoordinatorDelegate {
    func showMovieDetail(asset id: Int) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: MovieDetailCoordinatorDelegate {}
