//
//  RepositoryContainer.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import NetworkInterface
import StorageInterface

public class RepositoryContainer {
    private let networkProvider: NetworkProviderInterface
    private let storage: KeyValueStorable

    public let movieRepository: MovieRepositoryable

    public init(_ networkProvider: NetworkProviderInterface, storage: KeyValueStorable) {
        self.networkProvider = networkProvider
        self.storage = storage
        movieRepository = MovieRepository(networkProvider, storage: storage)
    }
}
