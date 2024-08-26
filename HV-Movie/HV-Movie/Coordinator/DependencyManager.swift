//
//  DependencyManager.swift
//  HV-Movie
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import Data
import Network
import Storage
import NetworkInterface
import StorageInterface
import ToolKit
import TrackingKit

/// A utility class that manages the registration of dependencies within a dependency container.
/// This class is designed to separate the implementation details of dependency injection
/// from the rest of the application, ensuring a clean and modular structure.
final class DependencyManager {
    private(set) var container: DependencyContainerProtocol

    init(container: DependencyContainerProtocol = DependencyContainer.shared) {
        self.container = container
    }

    func registerDependencies() {
        registerEnv()
        registerLogger()
        registerImageLoader()
        registerNetworkService()
        registerKeyValueStorage()
        registerRepositoryContainer()
    }

    private func registerEnv() {
        container.register(EnvManageable.self, instance: EnvManager(current: .dev))
    }
    
    private func registerLogger() {
        container.register(ErrorLoggable.self, instance: Logger())
    }
    
    private func registerImageLoader() {
        container.register(ImageLoaderProtocol.self, instance: ImageLoader())
    }
    
    private func registerNetworkService() {
        container.register(NetworkProviderInterface.self, instance: NetworkProvider())
    }

    private func registerKeyValueStorage() {
        container.register(KeyValueStorable.self, instance: KeyValueStorage(defaults: .standard))
    }
    
    private func registerRepositoryContainer() {
        let networkService = container.resolve(NetworkProviderInterface.self)
        let storageService = container.resolve(KeyValueStorable.self)
        let instance = RepositoryContainer(networkService, storage: storageService)
        instance.movieRepository.fetchAllFavoriteFromStorage()
        container.register(RepositoryContainer.self, instance: instance)
    }
}
