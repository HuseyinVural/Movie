//
//  DependencyContainer.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

/// A simple dependency injection container that registers and resolves dependencies.
/// The `resolve` method uses force unwrapping (`!`) intentionally to highlight missing registrations,
/// making it easier to catch errors during development.
public protocol DependencyContainerProtocol {
    func register<T>(_ type: T.Type, instance: Any)
    func resolve<T>(_ type: T.Type) -> T
}

/// A basic implementation of a dependency container.
/// Dependencies are registered and resolved based on their type.
/// Force unwrapping in `resolve` is used to ensure that all dependencies are properly registered.
final public class DependencyContainer: DependencyContainerProtocol {
    private var factories = [String: Any]()
    
    public static let shared: DependencyContainerProtocol = DependencyContainer()
    
    init() {}
    
    public func register<T>(_ type: T.Type, instance: Any) {
        let key = String(describing: type)
        factories[key] = instance
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        return factories[key]! as! T
    }
}
