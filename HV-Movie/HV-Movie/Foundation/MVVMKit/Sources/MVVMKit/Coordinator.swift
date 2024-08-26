//
//  Coordinator.swift
//  HV-Movie
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import UIKit

/// The `Coordinator` protocol is designed to handle the navigation flow within a modular application architecture.
/// Coordinators manage the navigation stack and are responsible for controlling the flow between different view controllers.
/// Each feature or module within the app can have its own Coordinator, which communicates with a parent Coordinator to manage the flow between modules.
///
/// Usage:
/// - Implement the `Coordinator` protocol in your coordinator classes to manage navigation within a specific module or feature.
/// - Use the `start()` method to initiate the navigation flow for the module handled by the Coordinator.
/// - Use the `didFinish()` method to notify the parent Coordinator when the current Coordinator's work is complete and it can be removed from memory.
/// - The `popViewController(animated:)` method is provided as a convenience to pop the current view controller from the navigation stack. Optional
///
/// Example:
/// ```swift
/// class MovieDetailCoordinator: Coordinator {
///     var parent: Coordinator?
///     var childCoordinators = [Coordinator]()
///     var navigationController: UINavigationController?
///
///     func start() {
///         let movieDetailViewController = MovieDetailViewController()
///         movieDetailViewController.delegate = self
///         navigationController?.pushViewController(movieDetailViewController, animated: true)
///     }
/// }
/// `
public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
    func didFinish()
}

public extension Coordinator {
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func didFinish() {
        if let index = parent?.childCoordinators.firstIndex(where: { $0 === self }) {
            parent?.childCoordinators.remove(at: index)
        }
    }
}

