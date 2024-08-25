//
//  Coordinator.swift
//  HV-Movie
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

public extension Coordinator {
    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}

