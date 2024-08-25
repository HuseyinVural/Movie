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
        let moviesCoordinator = MoviesCoordinator(navigationController: navigationController)
        moviesCoordinator.delegate = self
        childCoordinators.append(moviesCoordinator)
        moviesCoordinator.start()
    }
}

extension AppCoordinator: MoviesCoordinatorDelegate {
    func showMovieDetail(asset id: Int) {
        #warning("Add navigation to detai")
    }
}
