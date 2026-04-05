//
//  Resolver.swift
//  Movies
//
//  Created by Mina Magdy on 01/04/2026.
//

import Foundation

@MainActor
final class Resolver {
    static let shared = Resolver()
    private var factories: [String: () -> Any] = [:]
    private static var didBootstrap = false

    private init() {}

    static func bootstrapIfNeeded() {
        guard !didBootstrap else { return }
        didBootstrap = true
        bootstrap()
    }

    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        factories[String(reflecting: type)] = factory
    }

    func resolve<T>(_ type: T.Type) -> T {
        let key = String(reflecting: type)
        guard let factory = factories[key], let instance = factory() as? T else {
            fatalError("No registration for \(key)")
        }
        return instance
    }

    private static func bootstrap() {
        let reachability = ReachabilityService()
        let networkClient = NetworkClient()
        let remote = MoviesRemoteDataSource(client: networkClient)
        let diskCache = MovieListDiskCacheFactory.makeDefault()

        // Data layer
        shared.register(MoviesRepository.self) {
            MoviesRepository(remote: remote, cache: diskCache, reachability: reachability)
        }

        // Domain use cases — registered against their protocols
        shared.register((any GetMoviesUC).self) {
            GetMoviesUseCase(repository: shared.resolve(MoviesRepository.self)) as any GetMoviesUC
        }

        shared.register((any GetGenresUC).self) {
            GetGenresUseCase(repository: shared.resolve(MoviesRepository.self)) as any GetGenresUC
        }

        shared.register((any GetMovieDetailsUC).self) {
            GetMovieDetailsUseCase(repository: shared.resolve(MoviesRepository.self)) as any GetMovieDetailsUC
        }

        // Presentation view models
        shared.register(HomeViewModel.self) {
            HomeViewModel(
                getMoviesUseCase: shared.resolve((any GetMoviesUC).self),
                getGenresUseCase: shared.resolve((any GetGenresUC).self),
                reachability: reachability
            )
        }
    }
}
